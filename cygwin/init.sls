#### CYGWIN/INIT.SLS --- Salt states managing Cygwin

### Copyright (c) 2017, Matthew X. Economou <xenophon@irtnog.org>
###
### Permission to use, copy, modify, and/or distribute this software
### for any purpose with or without fee is hereby granted, provided
### that the above copyright notice and this permission notice appear
### in all copies.
###
### THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
### WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
### WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
### AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
### CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
### LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
### NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
### CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

### This file installs and configures Cygwin.  The key words "MUST",
### "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD
### NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to
### be interpreted as described in RFC 2119,
### https://tools.ietf.org/html/rfc2119.  The key words "MUST (BUT WE
### KNOW YOU WON'T)", "SHOULD CONSIDER", "REALLY SHOULD NOT", "OUGHT
### TO", "WOULD PROBABLY", "MAY WISH TO", "COULD", "POSSIBLE", and
### "MIGHT" in this document are to be interpreted as described in RFC
### 6919, https://tools.ietf.org/html/rfc6919.  The keywords "DANGER",
### "WARNING", and "CAUTION" in this document are to be interpreted as
### described in OSHA 1910.145,
### https://www.osha.gov/pls/oshaweb/owadisp.show_document?p_table=standards&p_id=9794.

{%- from "cygwin/map.jinja" import cygwin_settings with context %}

cygwin:
  cmd.script:
    - source: {{ cygwin_settings.installer|yaml_encode }}
    - name: {{ 'cmd -f -d -q -g -s %s -O -P %s'|format(
                 cygwin_settings.mirrors|join(' -s '),
                 cygwin_settings.packages|join(','),
               )|yaml_encode }}
    - cwd: {{ salt['environ.get']('TMP')|yaml_encode }}

  file.recurse:
    - name: {{ cygwin_settings.prefix|yaml_encode }}
    - source: salt://cygwin/files
    - template: jinja
    - require:
        - cmd: cygwin

#### CYGWIN/INIT.SLS ends here.
