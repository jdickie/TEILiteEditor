<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="*">
        <xsl:variable name="elementValue" select="text()"/>
        <xsl:variable name="span-margin-left" select="concat('margin-left:', count(ancestor::*) * 50, 'px;')"/>
        <span style="margin-left:50px;width:690px;">
            <span class="elementName">
                <xsl:value-of select="concat('&lt;',local-name(.))"/>
            </span>
            <xsl:for-each select="@*">
                <xsl:call-template name="attrs"/>
            </xsl:for-each>
            <span class="elementName">
                <xsl:text>&gt;</xsl:text>
            </span>
            <xsl:choose>
                <xsl:when test="child::*">
                    <xsl:choose>
                        <xsl:when test="$elementValue">
                            <span class="elementValue">
                                <xsl:value-of select="$elementValue"/>
                            </span>
                            <xsl:apply-templates select="child::*"/>
                            <span class="elementName">
                                <xsl:value-of select="concat('&lt;/',local-name(), '&gt;')"/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="elementName">
                                <xsl:text> </xsl:text>
                            </span>
                            <xsl:apply-templates select="child::*"/>
                            <span class="elementName">
                                <xsl:value-of select="concat('&lt;/',local-name(), '&gt;')"/>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <span class="elementName">
                        <xsl:value-of select="concat(., '&lt;/',local-name(), '&gt;')"/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

   <!-- attribute nodes -->
    <xsl:template name="attrs">
        <span class="attributeName">
            <xsl:value-of select="concat(name(.), '=')"/>
        </span>
        <span class="attributeValue">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>"</xsl:text>
        </span>
    </xsl:template>

   <!-- empty nodes -->
<!--    <xsl:template match="*[not(*) and not(@*)] and not(.)">
            <span class="elementName">
                <xsl:value-of select="concat('<',local-name(), '/>')"/>
            </span>
    </xsl:template>-->
</xsl:stylesheet>