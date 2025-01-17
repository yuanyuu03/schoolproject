% Parameters used
alpha = 1.1; beta = 0.02; delta = 0.01; gamma = 1.5;
t0 = 0; t_end = 20; h = 0.01;
y0 = [40; 9];  % number of rabbits and foxes at t=0

% Initialize
t = t0:h:t_end;        % from t0 to t_end, by step 0.01; output=[0, 0.01, 0.02,..., 20]
n = length(t);         % number of t
y = zeros(2, n);       % two row, n column of 0
y(:,1) = y0;           % initialize, first column is y0
set(0, 'DefaultAxesFontSize', 40);
set(0, 'DefaultTextFontSize', 50);

function dy = f(t, y)
    % Define constants
    alpha = 1.1; beta = 0.02; delta = 0.01; gamma = 1.5;

    % Current state
    X = y(1);  % Prey (rabbits) population
    Y = y(2);  % Predator (foxes) population

    % Differential equations
    dy = zeros(2, 1);
    dy(1) = alpha * X - beta * X * Y;    % dX/dt (rabbit growth and predation)
    dy(2) = delta * X * Y - gamma * Y;   % dY/dt (fox growth and mortality)
end

% RK4
for i = 1:n-1
    t_i = t(i);
    y_i = y(:, i);

    % Calculate k1, k2, k3, k4
    k1 = h*f(t_i, y_i);
    k2 = h*f(t_i + h/2, y_i + k1/2);
    k3 = h*f(t_i + h/2, y_i + k2/2);
    k4 = h*f(t_i + h, y_i + k3);

    % Update the next value
    y(:, i+1) = y_i + 1/6 * (k1 + 2*k2 + 2*k3 + k4);
end


% Plot Rabbit
figure;
plot(t, y(1, :), 'g');
xlabel('Time');
ylabel('Rabbit Population');
title('Rabbit Population Over Time');

% Plot Fox
figure;
plot(t, y(2, :), 'r');
xlabel('Time');
ylabel('Fox Population');
title('Fox Population Over Time');

% Plot Rabbit, Fox vs time
figure;
plot(t, y(1, :), 'g', t, y(2, :), 'r');
legend('Rabbit', 'Fox');
xlabel('Time');
ylabel('Population');
title('Rabbit, Fox Population vs Time');

% Plot Rabbit vs Fox
figure;
plot(y(1, :), y(2, :));
xlabel('Rabbit Population');
ylabel('Fox Population');
title('Rabbit Population Vs Fox Population');

% Display the data,
disp('Time      Rabbit      Fox');
disp([t' y(1,:)' y(2,:)']); % Display time, rabbit, and fox populations
