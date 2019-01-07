*********************************************************************
  Sample proglams of Introduction to Humanoid Robotics
  Author: S.Kajita, AIST

  2018 Jan.   7 GitHub repository  s-kajita/IntroductionToHumanoidRobotics
  2013 Sept. 23 Updated
  2005 April 15 Original
*********************************************************************

[Usage]
Copy all files into your favorite directry. Type following command 
in Matlab's command line.

Section 2 Kinematics
    ulink_example : Example of recursive call programming (2.4.2)
    fk_random     : Draw biped robot with random joint angles(2.5.2)
    ik_random     : Draw robot with random foot place and orientation(2.5.3)
    ik_random2    : ik_random with numerical inverse kinemaitcs(2.5.4)
    ik_stretch_NR : Behavior of Newton-Raphson method at singularity
    ik_stretch_LM : Levenberg-Marqardt method using singularity robust inverse

Section 3 ZMP and Dynamcis
    calcurate_zmp : Show ZMP(IZMP) of biped robot and the CoM projection(3.4.1)

Section 6 Dynamic simulation
    rigidbody_rotate : Animate rigid body rotation in zero-gravity (6.1.2)
    screw_motion     : Rigid body motin with constant spatial velocity(6.2.2)
    rigidbody_fly    : Rigid body translation and rotation in zero-gravity (6.3.3)
    top_simulation   : Animate top motion (6.3.4)
    robot_simulation : Dynamic simulation using unit-vector method(6.4.3)

Tested by
  Matlab for Windows ver.6.5, ver.7.0, and R2012b

-------------------------------------------------------------------
Note 0:
  These programs are no warranty. Use these programs with your 
  own risk. The author cannot be responsible for any trouble 
  caused by the software.

Note 1: Rules of naming (with some exceptions)
   Executable without arguments: All character of the file name are lower wase (ex: ulink_example.m)
   Subroutines (need arguments): Contains upper case character (ex: PrintLinkName.m) 

Note 2: Matlab for Linux
   It works at the authors envoriment Vine Linux2.6 + Matlab ver.6.5.

Note 3: If you get unusual 3D graphics
   Please try the following command. It might work... 
        set(0,'DefaultFigureRenderer','zbuffer')
