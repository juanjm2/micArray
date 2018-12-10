from scipy.io.wavfile import write
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy.io import wavfile

def volumeControl(x):
    numerator = x / 20
    return 10**numerator

print(volumeControl(0))
####################################################################################################

F = open("OUT.dat", "r")

data_l = []
data_r = []

for line in F:
    l_sample = int(line.split()[0], 16)
    l_sample = l_sample * volumeControl(-20)
    r_sample = int(line.split()[1], 16)
    r_sample = r_sample * volumeControl(-20)
    data_l.append(l_sample)
    data_r.append(r_sample)

F.close()

data_l = np.asarray(data_l, dtype=np.int16)
data_r = np.asarray(data_r, dtype=np.int16)
print(data_l.shape)
print(data_r.shape)

data = np.stack((data_l, data_r))
data = np.transpose(data)
print(data.shape)

write('mic_pair_1.wav', 48000, data)

####################################################################################################

F = open("OUT2.dat", "r")

data_l = []
data_r = []

for line in F:
    l_sample = int(line.split()[0], 16)
    r_sample = int(line.split()[1], 16)

    data_l.append(l_sample)
    data_r.append(r_sample)

F.close()

data_l = np.asarray(data_l, dtype=np.int16)
data_r = np.asarray(data_r, dtype=np.int16)
print(data_l.shape)
print(data_r.shape)

data = np.stack((data_l, data_r))
data = np.transpose(data)
print(data.shape)

write('mic_pair_2.wav', 48000, data)

####################################################################################################

F = open("OUT3.dat", "r")

data_l = []

for line in F:
    data_l.append(line)

F.close()

data_l = np.asarray(data_l, dtype=np.int32)

F = open("OUT4.dat", "r")

data_r = []

for line in F:
    data_r.append(line)
F.close()

data_r = np.asarray(data_r, dtype=np.int32)

data = np.stack((data_l, data_l))
data = np.transpose(data)
print(data.shape)

write('fpga_lowpass_output.wav', 48000, data)

####################################################################################################

F = open("OUT5.dat", "r")

data_l = []
data_r = []

for line in F:
    l_sample = int(line.split()[0], 16)
    l_sample = l_sample * volumeControl(-10)
    r_sample = int(line.split()[1], 16)
    r_sample = r_sample * volumeControl(-10)
    data_l.append(l_sample)
    data_r.append(r_sample)

F.close()

data_l = np.asarray(data_l, dtype=np.int32)
data_r = np.asarray(data_r, dtype=np.int32)
print(data_l.shape)
print(data_r.shape)

data = np.stack((data_l, data_r))
data = np.transpose(data)
print(data.shape)

write('line_in_output.wav', 48000, data)

####################################################################################################