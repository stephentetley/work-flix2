/*
 * Copyright 2024 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



pub def main(): Unit \ IO = 
    let ans = FlocRewriting.Rewrite.rewrite(sysHints(), subsysHints());
    List.forEach(println, ans)

def sysHints(): List[(String, String, Int32)] = List#{
    ("BLG", "Kiosk System", 1),
    ("FLA", "Detention Tank System", 1),
    ("OAC", "Odour Control System", 1)
}

def subsysHints(): List[(String, String, Int32, String, Int32)] = List#{
    ("OAC", "Vent Stack", 1, "STAK", 1), 
    ("FLA", "Detention Tank", 1, "TANK", 1), 
    ("FLA", "Tank Sewer", 1, "TANK", 2),
    ("FLA", "M01101 No 1 Return Pump", 1, "PUMP", 1), 
    ("FLA", "M01102 No 2 Return Pump", 1, "PUMP", 2)
}



