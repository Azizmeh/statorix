<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
<head>
    <meta charset="UTF-8"/>
    <style>
        body {
            font-family: Arial;
            margin: 30px;
        }
        ul {
            list-style-type: none;
            padding-left: 20px;
        }
        li {
            margin: 6px 0;
        }
        .code {
            color: #666;
            font-size: 12px;
            margin-right: 8px;
        }
        .libelle {
            font-weight: bold;
            color: #1d4ed8;
        }
    </style>
</head>
<body>
    <h2>Liste des catégories juridiques</h2>
    <ul>
        <xsl:apply-templates select="categories_juridiques/categorie_juridique"/>
    </ul>
</body>
</html>
</xsl:template>

<xsl:template match="categorie_juridique">
    <li>
        <span class="code">(<xsl:value-of select="@code"/>)</span>
        <span class="libelle">
            <xsl:value-of select="@libelle"/>
        </span>

        <xsl:if test="categorie_juridique">
            <ul>
                <xsl:apply-templates select="categorie_juridique"/>
            </ul>
        </xsl:if>
    </li>
</xsl:template>

</xsl:stylesheet>