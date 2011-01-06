<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="*">
        <xsl:variable name="TEIelementName">
            <xsl:value-of select="local-name(.)"/>
        </xsl:variable>
        <xsl:if test="./text()">
            <xsl:element name="span">
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="class">
                    <xsl:value-of select="$TEIelementName"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="not(./text())">
            <xsl:element name="span">
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="class">
                    <xsl:value-of select="$TEIelementName"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>