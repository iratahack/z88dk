SUBDIRS = isr dstar TurboSound
CLEANDIRS = $(SUBDIRS:%=%-clean)


.PHONY: subdirs $(SUBDIRS) $(CLEANDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean: $(CLEANDIRS)

$(CLEANDIRS): 
	$(MAKE) -C $(@:%-clean=%) clean
