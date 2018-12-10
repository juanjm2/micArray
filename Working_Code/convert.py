from scipy.io.wavfile import write
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy.io import wavfile

####################################################################################################

F = open("OUT.dat", "r")

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

write('out.wav', 48000, data)

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

write('out2.wav', 48000, data)

####################################################################################################

F = open("OUT3.dat", "r")

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

write('out3.wav', 48000, data)

####################################################################################################

F = open("OUT4.dat", "r")

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

write('out4.wav', 48000, data)

####################################################################################################

F = open("OUT5.dat", "r")

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

write('out5.wav', 48000, data)

####################################################################################################