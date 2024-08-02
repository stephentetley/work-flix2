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

    pub def rewrite(): List[(String, String, Int32, String)] = 
        let ss1 = FlocRewriting.Sites.siteMapping();
        let siteMapping = inject ss1 into SiteMap;
        let ws1 = FlocRewriting.Worklist.worklist();
        let worklist = inject ws1 into WorkList;
        let kids1 = FlocRewriting.Worklist.childOf();
        let descendents = inject kids1 into ChildOf;
        let rules = level01() <+> level02();
        let ans = query siteMapping, worklist, descendents, rules select (a ,b, c, d) from Floc(a, b, c, d);
        Vector.toList(ans)


    def level01(): #{ Floc(String, String, Int32, String),
                        FlocMapping(String, String), 
                        WorkList(String, String, String, String), 
                        SiteMap(String, String, String, String) | r} = #{
        Floc(s4Floc, s4name, 1, "SITE") :- 
            WorkList(aibSaiNum, _, _, "SITE"),
            SiteMap(aibSaiNum, _, s4Floc, s4name).

        FlocMapping(aibSaiNum, s4Floc) :- 
            WorkList(aibSaiNum, _, _, "SITE"),
            SiteMap(aibSaiNum, _, s4Floc, _).

    }

    def level02(): #{ Floc(String, String, Int32, String), 
                        FlocMapping(String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String) | r} = #{
        Floc(s4Parent + "CAA", "Control and Automation", 2, "CAA") :- 
            WorkList(aibSaiNum, _, "CONTROL SERVICES", "PROCESS_GROUP"),
            ChildOf(aibSaiNum, aibParent),
            FlocMapping(aibParent, s4Parent).

        FlocMapping(aibSaiNum, s4Parent + "CAA") :- 
            WorkList(aibSaiNum, _, "CONTROL SERVICES", "PROCESS_GROUP"),
            ChildOf(aibSaiNum, aibParent),
            FlocMapping(aibParent, s4Parent).
    }

}
