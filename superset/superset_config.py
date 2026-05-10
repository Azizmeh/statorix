import logging

from flask import redirect, request, session
from flask_appbuilder.security.manager import AUTH_OAUTH
from superset.security import SupersetSecurityManager

SECRET_KEY = "9CtcsF0Oil72+Ty8VvjVXmpy0YhWUQr78HrBtB85oOzYJo0GiCib81q5"

SQLALCHEMY_DATABASE_URI = (
    "postgresql+psycopg2://statorix:statorix_pwd@postgres:5432/statorix"
)

FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

BABEL_DEFAULT_LOCALE = "fr"
LANGUAGES = {
    "fr": {"flag": "fr", "name": "French"},
}

AUTH_TYPE = AUTH_OAUTH
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Viewer"
AUTH_ROLES_SYNC_AT_LOGIN = True

AUTH_ROLES_MAPPING = {
    "admin": ["Admin"],
    "analyste": ["Alpha"],
    "lecteur": ["Viewer"],
}

_REALM = "statorix"
_KC_INTERNAL = f"http://nginx/realms/{_REALM}"
_KC_EXTERNAL = f"http://localhost/realms/{_REALM}"

THEME_DEFAULT = {
    "token": {
        "brandLogoUrl": "/static/assets/images/statorix_logo.svg",
        "brandLogoAlt": "Statorix",
        "brandLogoHref": "http://localhost",
        "brandIconMaxWidth": 220,
        "brandLogoHeight": "60px",
    }
}

THEME_DARK = {
    "token": {
        "brandLogoUrl": "/static/assets/images/statorix_logo_dark.svg",
        "brandLogoAlt": "Statorix",
        "brandLogoHref": "http://localhost",
        "brandIconMaxWidth": 220,
        "brandLogoHeight": "60px",
    },
    "algorithm": "dark",
}

OAUTH_PROVIDERS = [
    {
        "name": "keycloak",
        "icon": "fa-key",
        "token_key": "access_token",
        "remote_app": {
            "client_id": "superset",
            "client_secret": "wZxqgImOvnVYdanTNu0OgPdN495BLscD",
            "api_base_url": f"{_KC_INTERNAL}/protocol/openid-connect/",
            "access_token_url": f"{_KC_INTERNAL}/protocol/openid-connect/token",
            "jwks_uri": f"{_KC_INTERNAL}/protocol/openid-connect/certs",
            "authorize_url": f"{_KC_EXTERNAL}/protocol/openid-connect/auth",
            "redirect_uri": "http://localhost:8088/oauth-authorized/keycloak",
            "client_kwargs": {
                "scope": "openid email profile",
            },
        },
    }
]


def init_app(app):
    @app.before_request
    def auto_redirect_to_keycloak():
        if request.path == "/login/" and "next" in request.args:
            return redirect("/login/keycloak")

    @app.before_request
    def redirect_viewer_to_dashboards():
        if request.path == "/superset/welcome/":
            try:
                from flask_login import current_user
                if current_user.is_authenticated:
                    roles = [r.name for r in current_user.roles]
                    if "Viewer" in roles and "Admin" not in roles:
                        return redirect("/dashboard/list/")
            except Exception:
                pass

    @app.after_request
    def keycloak_logout(response):
        if request.path == "/logout/" and response.status_code == 302:
            id_token = session.get("id_token", "")
            keycloak_logout_url = (
                f"{_KC_EXTERNAL}/protocol/openid-connect/logout"
                f"?post_logout_redirect_uri=http://localhost"
                f"&client_id=superset"
                f"&id_token_hint={id_token}"
            )
            return redirect(keycloak_logout_url)
        return response


FLASK_APP_MUTATOR = init_app


class KeycloakSecurityManager(SupersetSecurityManager):
    def oauth_user_info(self, provider, response=None):
        if provider == "keycloak":
            me = self.appbuilder.sm.oauth_remotes[provider].get("userinfo")
            if me.status_code != 200:
                logging.error(
                    "Keycloak userinfo error: %s %s", me.status_code, me.text
                )
                return {}
            data = me.json()
            logging.warning("KEYCLOAK USERINFO=%s", data)

            # Stocke l'id_token pour le logout SSO
            if response and "id_token" in response:
                session["id_token"] = response["id_token"]

            roles = data.get("realm_access", {}).get("roles", [])
            logging.warning("KEYCLOAK ROLES=%s", roles)

            return {
                "username": data.get("preferred_username"),
                "first_name": data.get("given_name", ""),
                "last_name": data.get("family_name", ""),
                "email": data.get("email", ""),
                "role_keys": roles,
            }
        return {}


CUSTOM_SECURITY_MANAGER = KeycloakSecurityManager

CORS_OPTIONS = {
    "origins": ["http://localhost"],
    "supports_credentials": True,
}
ENABLE_CORS = True

SESSION_COOKIE_DOMAIN = "localhost"
SESSION_COOKIE_SAMESITE = "Lax"
SESSION_COOKIE_SECURE = False