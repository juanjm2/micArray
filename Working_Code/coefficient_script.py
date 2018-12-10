from numpy import cos, sin, pi, absolute, arange
from scipy import signal
from scipy.signal import kaiserord, lfilter, firwin, freqz
from pylab import figure, clf, plot, xlabel, ylabel, xlim, ylim, title, grid, axes, show
import scipy.io.wavfile as sc
import numpy as np
import matplotlib.pyplot as plt
#------------------------------------------------
# Create a signal for demonstration.
#------------------------------------------------

sample_rate = 48000.0
nsamples = 720000
rate, data = sc.read('line_in_output.wav', mmap=False)
data = np.transpose(data)
#------------------------------------------------
# Create a FIR filter and apply it to x.
#------------------------------------------------

# The Nyquist rate of the signal.
nyq_rate = sample_rate / 2.0

# Compute the order and Kaiser parameter for the FIR filter.
N = 71

# The cutoff frequency of the filter.
cutoff_hz = 1000.0

# Use firwin with a Hamming window to create a lowpass FIR filter.
taps_low = firwin(N, cutoff_hz/nyq_rate, window='hamming')
taps_high = firwin(N, 1000.0, pass_zero=False, nyq=nyq_rate)

# Use lfilter to filter x with the FIR filter.
low_filtered_l = lfilter(taps_low, 1.0, data[0])
low_filtered_l = np.asarray(low_filtered_l, dtype=np.int16)
low_filtered_r = lfilter(taps_low, 1.0, data[1])
low_filtered_r = np.asarray(low_filtered_r, dtype=np.int16)
low_filtered_stereo = np.stack((low_filtered_l, low_filtered_r))
low_filtered_stereo = np.transpose(low_filtered_stereo)

high_filtered_l = lfilter(taps_high, 1.0, data[0])
high_filtered_l = np.asarray(high_filtered_l, dtype=np.int16)
high_filtered_r = lfilter(taps_high, 1.0, data[1])
high_filtered_r = np.asarray(high_filtered_r, dtype=np.int16)
high_filtered_stereo = np.stack((high_filtered_l, high_filtered_r))
high_filtered_stereo = np.transpose(high_filtered_stereo)

sc.write('lowpass_output.wav', 48000, low_filtered_stereo)
sc.write('highpass_output.wav', 48000, high_filtered_stereo)

f=open("lowpass_coefficient_script", "w+")
f.write("# banks: 1\n")
f.write("# coeffs: %d\n" % N)


for x in range(N):
    if x == N - 1:
        f.write("%f\n" % taps_low[x])
    else:
        f.write("%f, " % taps_low[x])

f.close()

f=open("highpass_coefficient_script", "w+")
f.write("# banks: 1\n")
f.write("# coeffs: %d\n" % N)


for x in range(N):
    if x == N - 1:
        f.write("%f\n" % taps_high[x])
    else:
        f.write("%f, " % taps_high[x])

f.close()