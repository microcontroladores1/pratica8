function pwm = deg2pwm( deg )

deg2 = deg + 90;

pwm = round(255*deg2/180);

end

