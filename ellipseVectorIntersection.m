
e1 = 1;
e2 = 2;

particlePos = [51.5 56];

newVelocity = [5 -3];

data = dataset_tspn2DE16_2;


plotEllipse( data(e1,1), data(e1,2), data(e1,3), data(e1,4) );
plotEllipse( data(e2,1), data(e2,2), data(e2,3), data(e2,4) );

plot(particlePos(1,1),particlePos(1,2), '*'); hold on

plot((particlePos(1,1) + newVelocity(1,1)),(particlePos(1,2) + newVelocity(1,2)), '*'); hold on

plot([particlePos(1,1) (particlePos(1,1) + newVelocity(1,1))], [particlePos(1,2), (particlePos(1,2) + newVelocity(1,2))], 'b-','LineWidth',3); hold on

XYproj = getNextBoarderPoint( data(e1,:), particlePos, (particlePos + newVelocity) );
 
deltaX = XYproj(1,1) - particlePos(1,1);
deltaY = XYproj(1,2) - particlePos(1,2);

if (deltaX / deltaX) > 0
    signX = -1;
else
    signX = 1;
end

if (deltaY / deltaY) > 0
    signY = -1;
else
    signY = 1;
end

%particlePosNew = particlePos;

particlePosNew(1,1) = XYproj(1,1);
particlePosNew(1,2) = XYproj(1,2);

plot(particlePosNew(1,1),particlePosNew(1,2), 'x','MarkerSize',10); hold on






