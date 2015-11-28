#!/bin/sh
exec scala -savecompiled "$0" "$@"
!#

/**
 * Usage:  MoveMouse.sh 10 20
 */

import java.awt.Robot

if (args.length != 2) {
    Console.err.println("Usage: MoveMouse x y")
    System.exit(1)
}

val x = args(0).toInt
val y = args(1).toInt

val robot = new Robot
robot.mouseMove(x, y)


