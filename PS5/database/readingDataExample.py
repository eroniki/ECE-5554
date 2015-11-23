import glob
import pdb
import os
from scipy.misc import imread
import matplotlib.pyplot as plt
import numpy
basedir = './'

actions = ['botharms', 'crouch', 'leftarmup', 'punch', 'rightkick']

outind = 1;
for actionnum in range(len(actions)):
	subdirname = basedir + actions[actionnum] + '/'
	subdir = os.listdir(subdirname)
	
	for seqnum in range(len(subdir)):
	# cycle through all sequences for this action category
       
		depthfiles = glob.glob(subdirname + subdir[seqnum] + '/' + '*.pgm');
		depthfiles = numpy.sort(depthfiles)
		for i in range(len(depthfiles)):
			depth = imread(depthfiles[i])
			plt.imshow(depth)
			plt.show()
