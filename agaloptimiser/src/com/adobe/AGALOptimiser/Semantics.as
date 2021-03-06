/*
Copyright (c) 2012 Adobe Systems Incorporated

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package com.adobe.AGALOptimiser {

import com.adobe.AGALOptimiser.error.Enforcer;
import com.adobe.AGALOptimiser.error.ErrorMessages;
import com.adobe.AGALOptimiser.utils.SerializationUtils;

use namespace nsinternal;

// semantics comes from the metadata tagging.  For example, the vertex buffer
// that provides the input position to the vertex kernel might look like this:
//
//     input vertex float3 inputPosition<id: "POSITION";>;
//
// a bone weight might be
//
//     input vertex float boneWeight<id: "WEIGHT"; index: 0;>;

/** 
 * Stores the semantic information that comes from the metadata tagging.
 * For example, the vertex buffer that provides the input position to the vertex kernel
 * might look like this:
 * <listing version="3.0">input vertex float3 inputPosition &lt;id: "POSITION";&gt;;</listing>
 * a bone weight might be
 * <listing version="3.0">input vertex float boneWeight &lt;id: "WEIGHT"; index: 0;&gt;;</listing>
 */

public final class Semantics
{
    private var id_    : String;
    private var index_ : int;

    /**
     * The constructor takes in a semantics as a string and an optional index value.
     * @param id A string identifying the semantics.
     * @param index An optional index value for the semantics.
     */
    public function Semantics(id : String,
                              index : int = -1)

    {
        Enforcer.checkNull(id);
        Enforcer.checkRange(index >= -1, ErrorMessages.SEMANTIC_INDEX_RESTRICTION);

        id_    = id;
        index_ = index;
    }

    /** @private */
    nsinternal function clone() : Semantics
    {
        return new Semantics(id_, index_);
    }

    /**
     * This method compares two semantic categories (both the id string
     * and index) and returns true if they match.
     * @param toCompare semantics to compare with.
     * @return Boolean indicating if the sematic categories match
     */
    
    public function equals(toCompare : Semantics) : Boolean
    {
        return ((toCompare != null) &&
                (toCompare.id == id_) &&
                (toCompare.index == index_));
    }

    /** Returns a string representation of the id information. */
    public function get id() : String
    {
        return id_;
    }

    /** Return the index.  This used primarily for boning and skinning as noted in the class information section. 
     @default -1 */
    public function get index() : int
    {
        return index_;
    }
    
    /** @private */
    nsinternal function serialize(indentLevel : int = 0,
                                     flags : int = 0) : String
    {
        var s : String = SerializationUtils.indentString(indentLevel);

        s += Constants.SEMANTICS_TAG;
        s += "(";
        s += this.toString();
        s += ")";

        return s;
    }

    /**
     * This method returns a concatenated string representing the id string
     * and its associated index as "id[index]".
     * @return A String representing the semantics object as "id[index]".
     */
    public function toString() : String
    {
        // REVIEW: what if id_ contains spaces, ", [, or ]?
        var result : String = id_;

        if (index_ >= 0)
            result += "[" + index_ + "]";

        return result;
    }

} // Semantics
} // com.adobe.AGALOptimiser.asm
