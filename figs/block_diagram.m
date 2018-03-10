clear;
clc;

Diagram2.Init();
global diagram;
diagram.blockBorderCurvature = 0.4;
diagram.circleBorderColor = [0 1 0];
diagram.blockFontSize = .1;
diagram.portFontSize = .1;

roof = 2.9;
space = 1.3;
Kinematics_block_x = 2.0;

%% Blocks
Ship_block = Block('\parbox[b]{15in}{\centering Vehicle Motion}', [0.4 roof], [3 0.8], {}, {}, {'INS','','INS','','','',''}, {});
Ship_block.backgroundColor = [141 212 255 128]/255;

Kinematics_block = Block(['\parbox[b]{15in}{\centering ISP \\ Kinematics}'], [Kinematics_block_x 1.7], [1.0 0.8], {'$q$','$\dot{q}$','$\ddot{q}$'}, {'$\eta_{{c_2}}$','$\dot{\eta}_{{c_2}}$'}, {}, {''});
Dynamics_block = Block(['\parbox[b]{15in}{\centering ISP \\ Dynamics}'], [Kinematics_block_x-space 1.7], [1.0 0.8], {'$\tau_q(t)$'}, {'$q$','$\dot{q}$','$\ddot{q}$'}, {}, {''});
Dynamics_block.backgroundColor = [255 140 140 128]/255;
Kinematics_block.backgroundColor = [255 140 140 128]/255;

InnerCTRL_block = Block(['\parbox[b]{15in}{\centering Stabilization \\ Controller}'], [Kinematics_block_x - 2*space 1.7], [1.0 0.8], {'$w(t)$'}, {'$\tau_q(t)$'}, {'$q$','$\dot{q}$'},  {''});
OuterCTRL_block = Block(['\parbox[b]{15in}{\centering Tracking \\ Controller}'], [Kinematics_block_x - 3*space 1.7], [1.0 0.8], {''}, {'$w(t)$'}, {'$\eta_{{c_2}}$','$\dot{\eta}_{{c_2}}$'}, {'$\eta_{d_2}$','$\dot{\eta}_{d_2}$','$\ddot{\eta}_{d_2}$',''});
InnerCTRL_block.backgroundColor = [153 255 133 128]/255;
OuterCTRL_block.backgroundColor = [153 255 133 128]/255;

Trajectory_block = Block(['\parbox[b]{15in}{\centering Trajectory \\ Generator}'], [Kinematics_block_x - 3*space roof], [1.0 0.8], {}, {}, {'$\eta_{d_2}$','$\dot{\eta}_{d_2}$','$\ddot{\eta}_{d_2}$',''}, {});
Trajectory_block.backgroundColor = [187 187 187 128]/255;

%% Points
left_pt_x = 2.8;

eta_pt = Kinematics_block.right(1).pos;
deta_pt = Kinematics_block.right(2).pos;
% ddeta_pt = Kinematics_block.right(3).pos;

eta_arrow = AutoArrow(eta_pt, [ left_pt_x eta_pt(2) -pi]);
deta_arrow = AutoArrow(deta_pt, [ left_pt_x deta_pt(2) -pi]);
% ddeta_arrow = AutoArrow(ddeta_pt, [ left_pt_x ddeta_pt(2) -pi]);

right_pt_x = -3.2;

etad_arrow = Arrow(Trajectory_block.down(1).pos, OuterCTRL_block.up(1).pos);
detad_arrow = Arrow(Trajectory_block.down(2).pos, OuterCTRL_block.up(2).pos);
ddetad_arrow = Arrow(Trajectory_block.down(3).pos, OuterCTRL_block.up(3).pos);

%% Arrows
Arrow_R_0b1 = Arrow(Ship_block.down(1).pos, OuterCTRL_block.up(end).pos); Arrow_R_0b1.filletRadius = 0.1; Arrow_R_0b1.extraPointsDistance = 0.15;
Arrow_R_0b2 = Arrow(Ship_block.down(3).pos, InnerCTRL_block.up(1).pos); Arrow_R_0b2.filletRadius = 0.1; Arrow_R_0b2.extraPointsDistance = 0.15;
Arrow_R_0b3 = Arrow(Ship_block.down(5).pos, Dynamics_block.up(1).pos); Arrow_R_0b3.filletRadius = 0.1; Arrow_R_0b3.extraPointsDistance = 0.15;
Arrow_R_0b4 = Arrow(Ship_block.down(end).pos, Kinematics_block.up(1).pos); Arrow_R_0b4.filletRadius = 0.1; Arrow_R_0b4.extraPointsDistance = 0.15;
% 
Arrow_q = Arrow(Dynamics_block.right(1).pos, Kinematics_block.left(1).pos);
Arrow_dq = Arrow(Dynamics_block.right(2).pos, Kinematics_block.left(2).pos);
Arrow_ddq = Arrow(Dynamics_block.right(3).pos, Kinematics_block.left(3).pos);
%
Arrow_q2 = AutoArrow(Dynamics_block.right(1).pos, InnerCTRL_block.down(1).pos, 0.05, 1.3); Arrow_q2.filletRadius = 0.1;
Arrow_dq2 = AutoArrow(Dynamics_block.right(2).pos, InnerCTRL_block.down(2).pos,0.01,1.2); Arrow_dq2.filletRadius = 0.1;
%
Arrow_tauq = Arrow(InnerCTRL_block.right(1).pos, Dynamics_block.left(1).pos);
Arrow_wt = Arrow(OuterCTRL_block.right(1).pos, InnerCTRL_block.left(1).pos);
% 
Arrow_inner_eta = AutoArrow(Kinematics_block.right(1).pos, OuterCTRL_block.down(1).pos,0.02,1.75); Arrow_inner_eta.filletRadius = 0.1; Arrow_inner_eta.lineStyle = '--';
Arrow_inner_deta = AutoArrow(Kinematics_block.right(2).pos, OuterCTRL_block.down(2).pos,0,2); Arrow_inner_deta.filletRadius = 0.1; Arrow_inner_deta.lineStyle = '--';
%

%% Print
Diagram2.Print();
set(gca, 'visible', 'off');
saveas(gcf,'HEADS_ctrl_observer','epsc')
saveas(gcf,'HEADS_ctrl_observer','jpg')
