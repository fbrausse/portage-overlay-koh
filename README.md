# portage-overlay-koh
My personal Gentoo portage overlay; it contains stuff I need/like and which
isn't in the official Gentoo portage tree. Plans are to submit as many of
these upstream...

To use it with layman, add the following as a new file: `/etc/layman/overlays/koh.xml`
```
<repositories>
  <repo quality="experimental" status="unofficial">
    <name>koh</name>
    <homepage>https://github.com/fbrausse/portage-overlay-koh</homepage>
    <owner type="person">
      <email>dev@karlchenofhell.org</email>
      <name>Franz Brauße</name>
    </owner>
    <source type="git">https://github.com/fbrausse/portage-overlay-koh.git</source>
    <source type="git">git://github.com/fbrausse/portage-overlay-koh.git</source>
    <source type="git">git@github.com:fbrausse/portage-overlay-koh.git</source>
    <feed>https://github.com/fbrausse/portage-overlay-koh/commits/master.atom</feed>
  </repo>
</repositories>
```
