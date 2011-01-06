<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--
  Copyright (c) 2006, Doeke Zanstra
  All rights reserved.

  Redistribution and use in source and binary forms, with or without modification, 
  are permitted provided that the following conditions are met:

  Redistributions of source code must retain the above copyright notice, this 
  list of conditions and the following disclaimer. Redistributions in binary 
  form must reproduce the above copyright notice, this list of conditions and the 
  following disclaimer in the documentation and/or other materials provided with 
  the distribution.

  Neither the name of the dzLib nor the names of its contributors may be used to 
  endorse or promote products derived from this software without specific prior 
  written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
  THE POSSIBILITY OF SUCH DAMAGE.
-->

<!-- Improvements 2009 01 22: Martynas Jusevičius http://www.xml.lt -->
    <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="UTF-8" media-type="application/json"/>
    <xsl:strip-space elements="*"/>

	<!-- include attributes in result? -->
    <xsl:param name="include-attrs" select="true()"/>

	<!--constant-->
    <xsl:variable name="d">0123456789</xsl:variable>

	<!-- used to identify unique children in Muenchian groupin -->
    <xsl:key name="elements-by-name" match="@* | *" use="concat(generate-id(..), '@', name(.))"/>

	<!-- ignore document text -->
    <xsl:template match="text()[preceding-sibling::node() or following-sibling::node()]"/>

	<!-- string -->
    <xsl:template match="text()">
        <xsl:call-template name="process-values">
            <xsl:with-param name="s" select="."/>
        </xsl:call-template>
    </xsl:template>

	<!-- text values (from text nodes and attributes) -->
    <xsl:template name="process-values">
        <xsl:param name="s"/>
        <xsl:choose>
			<!-- number -->
            <xsl:when test="not(string(number($s))='NaN')">
                <xsl:value-of select="$s"/>
            </xsl:when>
			<!-- boolean -->
            <xsl:when test="translate($s,'TRUE','true')='true'">true</xsl:when>
            <xsl:when test="translate($s,'FALSE','false')='false'">false</xsl:when>
			<!-- string -->
            <xsl:otherwise>
                <xsl:call-template name="escape-string">
                    <xsl:with-param name="s" select="$s"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!-- Main template for escaping strings; used by above template and for object-properties 
	Responsibilities: placed quotes around string, and chain up to next filter, escape-bs-string -->
    <xsl:template name="escape-string">
        <xsl:param name="s"/>
        <xsl:text>"</xsl:text>
        <xsl:call-template name="escape-bs-string">
            <xsl:with-param name="s" select="$s"/>
        </xsl:call-template>
        <xsl:text>"</xsl:text>
    </xsl:template>

	<!-- Escape the backslash (\) before everything else. -->
    <xsl:template name="escape-bs-string">
        <xsl:param name="s"/>
        <xsl:choose>
            <xsl:when test="contains($s,'\')">
                <xsl:call-template name="escape-quot-string">
                    <xsl:with-param name="s" select="concat(substring-before($s,'\'),'\\')"/>
                </xsl:call-template>
                <xsl:call-template name="escape-bs-string">
                    <xsl:with-param name="s" select="substring-after($s,'\')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="escape-quot-string">
                    <xsl:with-param name="s" select="$s"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!-- Escape the double quote ("). -->
    <xsl:template name="escape-quot-string">
        <xsl:param name="s"/>
        <xsl:choose>
            <xsl:when test="contains($s,'&#34;')">
                <xsl:call-template name="encode-string">
                    <xsl:with-param name="s" select="concat(substring-before($s,'&#34;'),'\&#34;')"/>
                </xsl:call-template>
                <xsl:call-template name="escape-quot-string">
                    <xsl:with-param name="s" select="substring-after($s,'&#34;')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="encode-string">
                    <xsl:with-param name="s" select="$s"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!-- Replace tab, line feed and/or carriage return by its matching escape code. Can't escape backslash
	or double quote here, because they don't replace characters (&#x0; becomes \t), but they prefix 
	characters (\ becomes \\). Besides, backslash should be seperate anyway, because it should be 
	processed first. This function can't do that. -->
    <xsl:template name="encode-string">
        <xsl:param name="s"/>
        <xsl:choose>
			<!-- tab -->
            <xsl:when test="contains($s,'&#x9;')">
                <xsl:call-template name="encode-string">
                    <xsl:with-param name="s" select="concat(substring-before($s,'&#x9;'),'\t',substring-after($s,'&#x9;'))"/>
                </xsl:call-template>
            </xsl:when>
			<!-- line feed -->
            <xsl:when test="contains($s,'&#xA;')">
                <xsl:call-template name="encode-string">
                    <xsl:with-param name="s" select="concat(substring-before($s,'&#xA;'),'\n',substring-after($s,'&#xA;'))"/>
                </xsl:call-template>
            </xsl:when>
			<!-- carriage return -->
            <xsl:when test="contains($s,'&#xD;')">
                <xsl:call-template name="encode-string">
                    <xsl:with-param name="s" select="concat(substring-before($s,'&#xD;'),'\r',substring-after($s,'&#xD;'))"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$s"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!-- object -->
    <xsl:template match="*">
		<!-- checks if this node should be in array (ie there are more siblings with the same name) -->
        <xsl:variable name="in-array" select="count(key('elements-by-name', concat(generate-id(..), '@', name(.)))) &gt; 1"/>
        <xsl:if test="position() = 1">{
		</xsl:if>
        <xsl:call-template name="escape-string">
            <xsl:with-param name="s" select="name()"/>
        </xsl:call-template>
        <xsl:text>:</xsl:text>
		<!-- if not in array, apply templates on unique children (which may represent a group of more than one, that becomes an array) -->
        <xsl:if test="not($in-array)">
            <xsl:choose>
                <xsl:when test="@* | child::node()">
                    <xsl:if test="$include-attrs">
                        <xsl:apply-templates select="@* | *[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                    </xsl:if>
                    <xsl:if test="not($include-attrs)">
                        <xsl:apply-templates select="*[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>null</xsl:otherwise>
            </xsl:choose>
        </xsl:if>
		<!-- if in array, apply templates on a group of equally-named sibling nodes -->
        <xsl:if test="$in-array">
            <xsl:apply-templates select="key('elements-by-name', concat(generate-id(..), '@', name(.)))" mode="array"/>
        </xsl:if>
        <xsl:if test="position() != last()">,
		</xsl:if>
        <xsl:if test="position() = last()">}
		</xsl:if>
    </xsl:template>

	<!-- array -->
    <xsl:template match="*" mode="array">
        <xsl:if test="position() = 1">[
		</xsl:if>
        <xsl:choose>
            <xsl:when test="@* | child::node()">
                <xsl:if test="$include-attrs">
                    <xsl:apply-templates select="@* | *[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                </xsl:if>
                <xsl:if test="not($include-attrs)">
                    <xsl:apply-templates select="*[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>null</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position() != last()">,
		</xsl:if>
        <xsl:if test="position() = last()">]
		</xsl:if>
    </xsl:template>

	<!-- attributes -->
    <xsl:template match="@*">
        <xsl:if test="position() = 1">{
		</xsl:if>
        <xsl:call-template name="escape-string">
            <xsl:with-param name="s" select="name()"/>
        </xsl:call-template>
        <xsl:text>:</xsl:text>
        <xsl:call-template name="process-values">
            <xsl:with-param name="s" select="."/>
        </xsl:call-template>
        <xsl:if test="position() != last()">,
		</xsl:if>
        <xsl:if test="position() = last()">}
		</xsl:if>
    </xsl:template>

	<!-- convert root element to an anonymous container -->
    <xsl:template match="/">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
</xsl:stylesheet>