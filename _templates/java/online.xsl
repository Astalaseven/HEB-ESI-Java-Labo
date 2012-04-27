﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:elml="http://www.elml.ch" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="../../../core/presentation/online/elml.xsl"/>
  <!-- ***** Parameter definitions  *****-->
  <!--The name of this layout (=folder name of template folder!) -->
  <xsl:param name="layout" select="'java'"/>
  <!--If you would like to have a navigation, set this to "yes" else (eg. for content package CP format) to "no" -->
  <!--<xsl:param name="use_navigation" select="'no'"/>-->
  <!-- ***** Template definitions  ***** -->
  <xsl:template name="elml:LayoutBody">
    <xsl:param name="prev">
      <xsl:call-template name="elml:prev_file"/>
    </xsl:param>
    <xsl:param name="next">
      <xsl:call-template name="elml:next_file"/>
    </xsl:param>
    <body>
      <xsl:if test="$manifest_type='scorm'">
        <xsl:attribute name="onunload">
          <xsl:value-of>finish()</xsl:value-of>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="elml:LayoutBodySkiplinks"/>
      <div class="navigation_arrows">
        <xsl:choose>
          <xsl:when test="$prev='none.html'">
            <img src="../../../_templates/{$layout}/navigation/back_off.gif" height="12" width="12" alt="No previous page available" border="0"/>
          </xsl:when>
          <xsl:otherwise>
            <a href="{$prev}">
              <img src="../../../_templates/{$layout}/navigation/back.gif" height="12" width="12" alt="Go to previous page" border="0"/>
            </a>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$next='none.html'">
            <img src="../../../_templates/{$layout}/navigation/next_off.gif" height="12" width="12" alt="No following page available" border="0"/>
          </xsl:when>
          <xsl:otherwise>
            <a href="{$next}">
              <img src="../../../_templates/{$layout}/navigation/next.gif" height="12" width="12" alt="Go to next page" border="0"/>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <xsl:call-template name="elml:navigation"/>
      <a name="top"/>
      <xsl:call-template name="elml:LayoutBodyContent"/>
      <hr/>
      <xsl:call-template name="elml:footer"/>
    </body>
  </xsl:template>
  <xsl:template match="elml:paragraph">
    <xsl:param name="display">
      <xsl:call-template name="elml:display"/>
    </xsl:param>
    <xsl:if test="$display='yes'">
      <xsl:if test="@title">
        <h4>
          <xsl:value-of select="@title"/>
          <xsl:if test="@icon and not($layout='none')">
            <img src="../../../_templates/{$layout}/icons/{@icon}.{$icon_filetype}" title="{@icon}" alt="{@icon}" class="icon"/>
          </xsl:if>
        </h4>
      </xsl:if>
      <p>
        <xsl:call-template name="elml:CSS_Class"/>
        <xsl:if test="@title">
          <xsl:attribute name="title">
            <xsl:value-of select="@title"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="elml:Label"/>
        <xsl:apply-templates/>
      </p>
    </xsl:if>
  </xsl:template>
  <xsl:template match="elml:formatted">
    <xsl:choose>
      <xsl:when test="@label or @cssClass or @labelRef">
        <span>
          <xsl:call-template name="elml:CSS_Class"/>
          <xsl:call-template name="elml:Label"/>
          <xsl:choose>
            <xsl:when test="@style='bold' and ($html_version='1.1' or $html_version='5')">
              <strong>
                <xsl:apply-templates/>
              </strong>
            </xsl:when>
            <xsl:when test="@style='bold'">
              <b>
                <xsl:apply-templates/>
              </b>
            </xsl:when>
            <xsl:when test="@style='subscript'">
              <sub>
                <xsl:value-of select="."/>
              </sub>
            </xsl:when>
            <xsl:when test="@style='superscript'">
              <sup>
                <xsl:value-of select="."/>
              </sup>
            </xsl:when>
            <xsl:when test="@style='italic' and ($html_version='1.1' or $html_version='5')">
              <em>
                <xsl:apply-templates/>
              </em>
            </xsl:when>
            <xsl:when test="@style='italic'">
              <i>
                <xsl:apply-templates/>
              </i>
            </xsl:when>
            <xsl:when test="@style='underlined'">
              <span style="text-decoration:underline;">
                <xsl:apply-templates/>
              </span>
            </xsl:when>
            <xsl:when test="@style='crossedOut' and ($html_version='1.1' or $html_version='5')">
              <del>
                <xsl:apply-templates/>
              </del>
            </xsl:when>
            <xsl:when test="@style='crossedOut'">
              <span style="text-decoration:line-through;">
                <xsl:apply-templates/>
              </span>
            </xsl:when>
            <xsl:when test="@style='upperCase'">
              <span style="text-transform:uppercase;">
                <xsl:apply-templates/>
              </span>
            </xsl:when>
            <xsl:when test="@style='lowerCase'">
              <span style="text-transform:lowercase;">
                <xsl:apply-templates/>
              </span>
            </xsl:when>
            <xsl:when test="@style='code'">
              <code>
                <xsl:apply-templates/>
              </code>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates/>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@style='bold' and ($html_version='1.1' or $html_version='5')">
            <strong>
              <xsl:apply-templates/>
            </strong>
          </xsl:when>
          <xsl:when test="@style='bold'">
            <b>
              <xsl:apply-templates/>
            </b>
          </xsl:when>
          <xsl:when test="@style='subscript'">
            <sub>
              <xsl:value-of select="."/>
            </sub>
          </xsl:when>
          <xsl:when test="@style='superscript'">
            <sup>
              <xsl:value-of select="."/>
            </sup>
          </xsl:when>
          <xsl:when test="@style='italic' and ($html_version='1.1' or $html_version='5')">
            <em>
              <xsl:apply-templates/>
            </em>
          </xsl:when>
          <xsl:when test="@style='italic'">
            <i>
              <xsl:apply-templates/>
            </i>
          </xsl:when>
          <xsl:when test="@style='underlined'">
            <span style="text-decoration:underline;">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="@style='crossedOut' and ($html_version='1.1' or $html_version='5')">
            <del>
              <xsl:apply-templates/>
            </del>
          </xsl:when>
          <xsl:when test="@style='crossedOut'">
            <span style="text-decoration:line-through;">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="@style='upperCase'">
            <span style="text-transform:uppercase;">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="@style='lowerCase'">
            <span style="text-transform:lowercase;">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="@style='code'">
            <code>
              <xsl:apply-templates/>
            </code>
          </xsl:when>
          <xsl:when test="@style='input'">
            <span class="input">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:when test="@style='java'">
            <div class="input">
              <pre><xsl:apply-templates/></pre>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Si titre dans popup ne pas metre le texte par déaut en plus)-->
  </xsl:template>
      <xsl:template match="elml:popup">
        <xsl:param name="display">
            <xsl:call-template name="elml:display"/>
        </xsl:param>
        <xsl:variable name="varname">
            <xsl:text>solution</xsl:text>
            <xsl:value-of select="generate-id()"/>
        </xsl:variable>
        <xsl:if test="$display='yes'">
            <p id="{$varname}" class="popupTitle" style="cursor: pointer;">
                <xsl:if test="not($layout='firedocs')">
                    <xsl:attribute name="onclick">
                        <xsl:text>onBlock('</xsl:text>
                        <xsl:value-of select="$varname"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:call-template name="elml:Label"/>
                <xsl:if test="@icon and not($layout='none')">
                    <xsl:call-template name="Icon">
                        <xsl:with-param name="icon" select="@icon"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="@title and not($name_solutiontext='')">
                        <xsl:value-of select="@title"/>
                    </xsl:when>
                    <xsl:when test="@title and $name_solutiontext=''">
                        <xsl:value-of select="@title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$name_solutiontext"/>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
            <div id="{$varname}text">
                <xsl:attribute name="style">
                    <xsl:choose>
                        <xsl:when test="$layout='firedocs'">
                            <xsl:text>cursor: pointer;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>display: none; cursor: pointer;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:call-template name="elml:CSS_Class"/>
                <xsl:if test="@title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@title"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="not($layout='firedocs')">
                    <xsl:attribute name="onclick">
                        <xsl:text>off('</xsl:text>
                        <xsl:value-of select="$varname"/>
                        <xsl:text>')</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="text()">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:if>
    </xsl:template>
<!-- fillInBlanks ne fonctionnait pas bien? J'ai ajouté explicitement un rnewline entre input et span -->
    <xsl:template match="elml:gap">
        <xsl:param name="selfCheckLabel"/>
        <xsl:param name="gap_stringlength">
            <xsl:choose>
                <xsl:when test="string-length(.)&lt;4">3</xsl:when>
                <xsl:when test="string-length(.)&lt;8">7</xsl:when>
                <xsl:when test="string-length(.)&lt;16">15</xsl:when>
                <xsl:when test="string-length(.)&lt;32">31</xsl:when>
                <xsl:otherwise>50</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <input type="text" value="" class="itemText" id="{$selfCheckLabel}_{generate-id(.)}" size="{$gap_stringlength}"/>
                <xsl:text>
                </xsl:text>
        <span class="gapText">
            <xsl:value-of select="."/>
            <xsl:if test="@answers!=''">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:value-of select="@answers"/>
        </span>
    </xsl:template>

</xsl:stylesheet>