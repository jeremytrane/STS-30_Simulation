function [M]=movie_atlantis(0,y(frame,1),y(frame,3),shuttle_angle(frame),shuttle_roll(frame),phi(frame),SRB_fuellevel(frame),current_fuel_levels_main(frame),height_truncation(frame),SRB_output(frame),Thrust_main(frame))

%movie_atlantis(0,y(frame,1),y(frame,3),shuttle_angle(frame),shuttle_roll(frame),phi(frame),SRB_fuellevel(frame),current_fuel_levels_main(frame),height_truncation(frame),SRB_output(frame),Thrust_main(frame))

[nx ny]=size(t);

c=1;

while time<125
    time=t(c);
end

%one being used is in animation file!!!!!!

for frame=1:nx-1
    
draw_atlantis(0,y(frame,1),y(frame,3),shuttle_angle(frame),shuttle_roll(frame),phi(frame),SRB_fuellevel(frame),current_fuel_levels_main(frame),height_truncation(frame),SRB_output(frame),Thrust_main(frame))
M(frame)=getframe()
clf

end

end
