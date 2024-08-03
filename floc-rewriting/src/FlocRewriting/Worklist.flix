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



mod FlocRewriting.Worklist {

    pub def worklist(): List[(String, String, String, String)] = List#{
        ("SAI00611686", "JUPITER AVENUE/DTK", "JUPITER AVENUE/DTK", "SITE"),
        ("SAI00644732", "JUPITER AVENUE/DTK/CONTROL SERVICES", "CONTROL SERVICES", "PROCESS_GROUP"),
        ("SAI00644733", "JUPITER AVENUE/DTK/CONTROL SERVICES/RTS MONITORING", "RTS MONITORING", "PROCESS"), 
        ("SAI00644734", "JUPITER AVENUE/DTK/CONTROL SERVICES/MPLC CONTROL", "MPLC CONTROL", "PROCESS"),
        ("SAI00647645", "JUPITER AVENUE/DTK/STATUTORY", "STATUTORY", "PROCESS_GROUP"),
        ("SAI00647646", "JUPITER AVENUE/DTK/STATUTORY/LIFTING EQUIPMENT", "LIFTING EQUIPMENT", "PROCESS")

    }

    // Facts extracted from WorkList
    pub def childsOf(xs: List[(String, String, String, String)]): List[(String, String)] = 
        def step(acc, x) = match (acc, x) {
            case (Nil, (sai, _, _, _)) => (Nil, (sai, "BAD"))
            case ((acc_sai, acc_cn) :: rs, (sai, common_name, _, _)) => {
                if (String.startsWith({prefix = acc_cn}, common_name)) 
                    ((sai, common_name) :: acc, (sai, acc_sai))
                else 
                    step(rs, x)
            }
        };
        match List.sortBy(match(_, common_name, _, _) -> common_name, xs) {
            case (sai, common_name, _, _) :: rs => Traversable.mapAccumLeft(step, (sai, common_name) :: Nil, rs) |> snd
            case Nil => Nil
        }

}
