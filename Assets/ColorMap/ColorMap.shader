Shader "Unlit/ColorMap"
{
    Properties
    {
        _ColorMap ("_ColorMap", 2D) = "white" {}
        _RotateAngle("_RotateAngle",float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        CGINCLUDE
        #include "ColorMap.hlsl" 
        ENDCG
       
        //基础的
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_rotate
            #pragma fragment frag_rotate
            #include "UnityCG.cginc"
           
            ENDCG
        }
        
    }
}
