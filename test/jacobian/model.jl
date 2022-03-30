
function rober!(du, u, p, t)
    y1, y2, y3 = u
    k1, k2, k3 = p

    du[1] = -k1 * y1 + k3 * y2 * y3
    du[2] = k1 * y1 - k2 * y2^2.0 - k3 * y2 * y3
    du[3] = k2 * y2^2.0

end

rober_model = DEsteady(
    func=rober!,
    u0=[1.0, 0.0, 0.0],
    p=[1.0, 0.0, 0.0]
)


function bistable_ode!(du, u, p, t)
    s1, s2 = u
    K1, K2, k1, k2, k3, k4, n1, n2 = p
    du[1] = k1 / (1 + (s2 / K2)^n1) - k3 * s1
    du[2] = k2 / (1 + (s1 / K1)^n2) - k4 * s2
end

bistable_model = DEsteady(
    func=bistable_ode!,
    p=[1.0, 1.0, 20.0, 20.0, 5.0, 5.0, 4.0, 4.0],
    u0=[3.0, 1.0]
)