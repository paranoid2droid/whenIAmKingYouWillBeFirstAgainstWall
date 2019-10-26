I focused on generate sounds of ocean waves.


In Wave.ck, I made a public class in which a Noise generator goes through a envelope, then passes a low pass filter.
You can set the ADSR parameters by a function. And by giving different parameters everytime we sonify it, it sounds like the waves besides a shore.
I also gave them a little bit reverb and diffdrent position every time.

In Shore.ck, I followed the way from the tweet example. First, the waves would swell from none to a max number. Then, when the waves number reach the max value, the wave would diminish one then add another one, kind of like how it acts in the real world.