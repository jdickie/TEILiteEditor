<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml"/>
    <xsl:template match="*">
        <xsl:variable name="TEIelementName">
            <xsl:value-of select="@class"/>
        </xsl:variable>
        <xsl:element name="{$TEIelementName}">
            <xsl:copy-of select="@*[not(contains('class style', name(.)))]"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="text()[. = ' ']"/>
</xsl:stylesheet>