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
        let kids1 = FlocRewriting.Worklist.childOf();
        let descendents = inject kids1 into ChildOf;
        let rules = level01() <+> level02() <+> level03() <+> level04();
        let ans = query siteMapping, worklist, descendents, rules select (a, b, c, d, e) from Floc(a, b, c, d, e);
        Vector.toList(ans)


    def level01(): #{ Floc(String, Int32, String, String, String),
                        FlocMapping(String, String), 
                        WorkList(String, String, String, String), 
                        SiteMap(String, String, String, String) | r} = #{
        Floc(aibSaiNum, 1, s4Floc, s4name, "SITE") :- 
            WorkList(aibSaiNum, _, _, "SITE"),
            SiteMap(aibSaiNum, _, s4Floc, s4name).

    }

    def level02(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{
        Floc(aibSaiNum, 2, s4Parent + "-CAA", "Control and Automation", "CAA") :- 
            WorkList(aibSaiNum, _, "CONTROL SERVICES", "PROCESS_GROUP"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 1, s4Parent, _, _).
    }

    def level03(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{
        Floc(aibSaiNum, 3, s4Parent + "-NET", "Networks", "NET") :- 
            WorkList(aibSaiNum, _, "RTS MONITORING", "PROCESS"),
            ChildOf(aibSaiNum, aibParent),
            Floc(aibParent, 2, s4Parent, _, _).
    }

    def level04(): #{ Floc(String, Int32, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{
        Floc(aibSaiNum, 4, s4Parent + "-TEL", "Telemetry", "TEL") :- 
            WorkList(aibSaiNum, _, "RTS MONITORING", "PROCESS"),
            Floc(aibSaiNum, 3, s4Parent, _, _).
    }

}
