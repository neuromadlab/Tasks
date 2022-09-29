# Body Silhouette Coloring Task (BodySilC)

Based on the emBODY task: Nummenmaa L., Glerean E., Hari R., Hietanen, J.K. (2014). Bodily maps of emotions, Proceedings of the National Academy of Sciences of United States of America doi:[10.1073/pnas.1321664111]
(http://www.pnas.org/content/111/2/646.abstract)

## What is this task about
This MATLAB task allows to color body silhouettes in an intuitive way (e.g. to assess bodily perceptions). You can select parts of the silhouette by using a mouse. Clicking the left button increases the color intensity, while clicking the right button leads to a decrease. There are two color scales implemented (for activation and deactivation). You can choose between two circular brush sizes (radius 6 pixels or 12 pixels). The color changing speed can be adapted (details below). Task instructions are available in German and English. For more details see the 'Settings/Modifications' section.

## What you need to run the task
*MATLAB (the task was written and tested within R2020a)
*Psychtoolbox 3.0 & gstreamer 1.0 (necessary for Psychtoolbox)
*BodySilC.m (task script)
*silhouette_settings.mat (needs to be stored in the same folder as BodySilC.m)
*Data and Backup folder in the same path

## Output: 
*RGB arrays with intensity values of activation and deactivation
*order of performed coloring actions (position in the picture, 1 (= increase in color intensity) or -1 (= decrease in color intensity))

## Settings/Modifications
*subj: Contains ID, session number, condition etc. You can adapt this to your needs as this information is mostly used to name the save files. You should not delete subj.language completely. This parameter defines the task language (currently available in German and English). You can add more languages, e.g. French (enter subj.language = fr, add lang_de = 2 ('Run in French') and add an if lang_de == 2 for each text string).
*settings: 
	*pic: Body silhouette RGB in black (1 1 1) and white (255 255 255). Size: 620 x 212 pixels. You can add more pictures easily, as long as they are RGB 3D arrays with only white & black starting colors (to use other starting colors, you need to adapt the color changing process). If your picture differs in size, you need to adapt the border detection (x_upper, x_lower, y_upper, y_lower).
	*brush: matrix for circular brush, available in 2 sizes (6 and 12 pixels radius), includes color intensity information following a gaussian distribution (i.e. central pixels within the brush will be colored more intensely than outer pixels). You can easily add another size or change the color intensity distribution. It's also possible to add differently shaped brushes.
  	*log_mask: logical mask (same shape and size as 'brush'), used to index pixels which lay inside the brush shape. If you add another brush, do not forget to add a corresponding log_mask as well.
	*arrow: Arrow picture used as 'continue'-button.
	*colorSpeed: This determines the number of steps between two colors in the color spectrum. If colorSpeed = 1, the center of the brush will reach the next color within three steps. Decreasing colorSpeed to 0.5 (i.e. six steps) leads to a smoother color gradient. It is not recommended to set colorSpeed >1. 
*GetMouse: The task requires button(1) to be the left mouse button and button(3) to be the right mouse button.
*color spectra: There are two preset color patterns (RGB code in brackets): 
	*activation: white (255 255 255) -> yellow (255 255 51) -> orange (255 140 0) -> red (255 0 0)
	*deactivation: white (255 255 255) -> light green (153 255 153) -> light blue (102 255 255) -> dark blue (51 153 255)
*ActivationCourse/InactivationCourse: These variables store the whole course of all performed actions. Currently, the central pixel (x and y coordinates) and the performed action (increase (=1) vs decrease (=-1)) are being saved.
*save: The current results will be stored after each completed silhouette (in the 'Data' and 'Backup' folder).
