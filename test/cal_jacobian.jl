function rober(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1*y1 + k3*y2*y3 
    du[2] = k1*y1 - k2*y2^2. - k3*y2*y3 
    du[3] = k2*y2^2.

end 

j_gen = jacobian(rober, [1.0,0.0,0.0], [1.0,0.0,0.0])


j_gen([1.0,1.0,1.0], [1.0,0.0,0.0])

