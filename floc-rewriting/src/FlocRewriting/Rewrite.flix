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



mod FlocRewriting.Rewrite {

    pub def rewrite(): List[(String, Int32, String, String, String)] = 
        let ss1 = FlocRewriting.Sites.siteMapping();
        let siteMapping = inject ss1 into SiteMap;
        let ws1 = FlocRewriting.Worklist.worklist();
        let worklist = inject ws1 into WorkList;
        let kids1 = FlocRewriting.Worklist.childsOf(ws1);
        let descendents = inject kids1 into ChildOf;
        let rules = level01() <+> level02() <+> level03() <+> level04() <+> level05();
        let ans = query siteMapping, worklist, descendents, rules select (a, b, c, d, e) from Floc(a, b, c, d, e);
        Vector.toList(ans) |> List.sortBy(match(_, _, floc, _, _) -> floc)


    def level01(): #{ Floc(String, Int32, String, String, String),
                        FlocMapping(String, String), 
                        WorkList(String, String, String, String), 
                        SiteMap(String, String, String, String) | r} = #{
        Floc(aibSaiNum, 1, s4Floc, s4name, "SITE") :- 
            WorkList(aibSaiNum, _, _, aibType),
            SiteMap(aibSaiNum, _, s4Floc, s4name).




    }

    def level02(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{
        Floc(aibSaiNum, 2, s4Parent + "-CAA", "Control and Automation", "CAA") :- 
            WorkList(aibSaiNum, _, _, "CONTROL SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 1, s4Parent, _, _).

        Floc(aibSaiNum, 2, s4Parent + "-SIF", "Site Infrastructure", "SIF") :- 
            WorkList(aibSaiNum, _, _, "INSTALLATION SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 1, s4Parent, _, _).

        Floc(aibSaiNum, 2, s4Parent + "-SMS", "Site Maint Services", "SMS") :- 
            WorkList(aibSaiNum, _, _, "STATUTORY"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 1, s4Parent, _, _).

    }

    def level03(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{

        Floc(aibSaiNum, 3, s4Parent + "-NET", "Networks", "NET") :- 
            WorkList(aibSaiNum, _, _, "RTS MONITORING"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 2, s4Parent, _, _).
        
        Floc(aibSaiNum, 3, s4Parent + "-CON", "Control", "CON") :- 
            WorkList(aibSaiNum, _, _, "MPLC CONTROL"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 2, s4Parent, _, _).

        Floc(aibSaiNum, 3, s4Parent + "-LFT", "Site Lifting", "LFT") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 2, s4Parent, _, _).

        Floc(aibSaiNum, 3, s4Parent + "-STM", "Structure Management", "STM") :- 
            WorkList(aibSaiNum, _, _, "STRUCTURES + SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 2, s4Parent, _, _).
    }

    def level04(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{

        Floc(aibSaiNum, 4, s4Parent + "-TEL", "Telemetry", "TEL") :- 
            WorkList(aibSaiNum, _, _, "RTS MONITORING"),
            Floc(aibSaiNum, 3, s4Parent, _, _).

        Floc(aibSaiNum, 4, s4Parent + "-LOC", "Logic Controllers", "LOC") :- 
            WorkList(aibSaiNum, _, _, "MPLC CONTROL"),
            Floc(aibSaiNum, 3, s4Parent, _, _).

        Floc(aibSaiNum, 4, s4Parent + "-FLT", "Fixed Lifting", "FLT") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Floc(aibSaiNum, 3, s4Parent, _, _).

        Floc(aibSaiNum, 4, s4Parent + "-PLR", "Portable Lifting", "PLR") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Floc(aibSaiNum, 3, s4Parent, _, _).
        
        Floc(aibSaiNum, 4, s4Parent + "-BLG", "Buildings", "BLG") :- 
            WorkList(aibSaiNum, _, _, "STRUCTURES + SERVICES"),
            Floc(aibSaiNum, 3, s4Parent, _, _).

    }

    def level05(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String) | r} = #{

        Floc(aibSaiNum, 5, s4Parent + "-SYS01", "Fixed Lifting System", "SLFS") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Floc(aibSaiNum, 4, s4Parent, _, "FLT").

        Floc(aibSaiNum, 5, s4Parent + "-SYS01", "Portable Lifting System", "SLFS") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Floc(aibSaiNum, 4, s4Parent, _, "PLR").

    }
}
