function [ R ] = return_resource( time )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a1 = 530;
b1 = 1.6;
c1 = 0.22;
R = a1 * time^b1 * exp(-c1 * time);


end

