<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0" exclude-result-prefixes="xs">
    <xsl:output method="xml"/>
    <xsl:template match="/">
        <teiann>
            <xsl:for-each select="/xs:schema/xs:complexType[@name = 'annType']/xs:sequence/xs:choice/xs:element">
                <xsl:variable name="elementName">
                    <xsl:value-of select="@name"/>
                </xsl:variable>
                <xsl:element name="{$elementName}">
                    <xsl:element name="class">
                        <xsl:value-of select="@name"/>
                    </xsl:element>
                    <xsl:for-each select="xs:complexType/xs:attribute">
                        <xsl:variable name="attributeName">
                            <xsl:value-of select="@name"/>
                        </xsl:variable>
                        <xsl:element name="{$attributeName}">
                            <xsl:copy-of select="@*[not(. = $attributeName)]"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </teiann>
    </xsl:template>
</xsl:stylesheet>