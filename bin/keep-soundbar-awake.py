import math, struct, subprocess, sys, time

sample_rate = 48000
freq = 15.0        # Below human hearing & soundbar frequency response
amplitude = 0.003  # ~ -50 dB (just enough non-zero digital signal)

# Generate a 1-second stereo 16-bit PCM buffer
chunk = bytearray()
for i in range(sample_rate):
    val = int(amplitude * 32767 * math.sin(2 * math.pi * freq * i / sample_rate))
    chunk.extend(struct.pack("<hh", val, val))

# Pipe directly into PipeWire (or fallback to PulseAudio)
player = ["pw-play", "--raw", "--rate=48000", "--channels=2", "--format=s16", "-"]
proc = subprocess.Popen(player, stdin=subprocess.PIPE)

if not proc.stdin:
	sys.stderr.write("Failed to open stdin for audio playback.\n")
	sys.exit(1)

try:
    while True:
        proc.stdin.write(chunk)        
        proc.stdin.flush()
        time.sleep(1)
except (BrokenPipeError, KeyboardInterrupt):
    pass
