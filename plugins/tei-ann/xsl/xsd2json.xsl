<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.0">
    <xsl:output method="text"/>
    <xsl:template match="xsd:element">
        <xsl:value-of select="@name"/> : { possibleParentElements : <xsl:value-of select="ancestor::xsd:element/@name"/>
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>