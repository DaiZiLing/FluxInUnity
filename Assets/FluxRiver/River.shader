Shader "River"
{
    Properties
    {
        [Header(Base Parameters)]
        
        // _RiverBaseColor ("Albedo Color", Color) = (1, 1, 1, 1)

        _RiverSmothness("Smothness", Range(0, 1)) = 0.5
        [HideInInspector]_RiverSmothnessStr("Smothness Strength", Range(1, 30)) = 15
        _RiverSSSMulti("SSS", Range(0, 5)) = 1
        _RiverDepthMulti("Visbity", Range(1, 100)) = 3

        _RiverScattering0 ("Scattering 0", Color) = (1, 1, 1, 1)
        _RiverScattering1 ("Scattering 1", Color) = (1, 1, 1, 1)
        [HideInInspector]_RiverAbsorption0 ("Absorption 0", Color) = (1, 1, 1, 1)
        _RiverAbsorption1 ("Absorption 1", Color) = (1, 1, 1, 1)
        _RefleFresnelPower("Fresnel Power", Range(1, 10)) = 1
        _RiverIndirectStr("Indirect Light", Range(0, 1)) = 0.1

        [Header(Debug Parameters)] // ======
        _RiverAbsorption0_Num ("Absorption Opaque", Range(0, 3)) = 1
        _RiverIndirectShadow("Indirect Shadow", Range(0, 2)) = 1
        _RiverDirectShadow("Direct Shadow", Range(0, 2)) = 1.5
        _RiverSSSShadow("SSS Shadow", Range(0, 1)) = 0.75
        _RiverSSSShadow2("SSS Shadow 2", Range(0, 1)) = 0.75
        _RiverSSSShadow3("SSS Shadow 3", Range(0, 1)) = 0.75
        _AbsorptionC("_AbsorptionC", Range(0, 2)) = 1.65
        _RiverSSPRShadow("_RiverSSPRShadow", Range(0, 2)) = 1.65

        [Header(Turbulence Parameters)]
        [NoScaleOffset]_RiverTurbulenceMap ("Turbulence Map", 2D) = "white" {}
        _RiverTurbulenceStr("Strength", Range(0, 1)) = 1
        _RiverTurbulenceTime("Time", Range(-100, 100)) = 1 // ======

        // [HideInInspector][Header(Debug Parameters)] // ======
        // [HideInInspector]_RiverAbsorption0_Num ("Absorption Opaque", Range(0, 3)) = 1
        // [HideInInspector]_RiverIndirectShadow("Indirect Shadow", Range(0, 2)) = 1
        // [HideInInspector]_RiverDirectShadow("Direct Shadow", Range(0, 2)) = 1.5
        // [HideInInspector]_RiverSSSShadow("SSS Shadow", Range(0, 1)) = 0.75
        // [HideInInspector]_RiverSSSShadow2("SSS Shadow 2", Range(0, 1)) = 0.75
        // [HideInInspector]_RiverSSSShadow3("SSS Shadow 3", Range(0, 1)) = 0.75
        // [HideInInspector]_AbsorptionC("_AbsorptionC", Range(0, 2)) = 1.65
        // [HideInInspector]_RiverSSPRShadow("_RiverSSPRShadow", Range(0, 2)) = 1.65

        // [HideInInspector][Header(Turbulence Parameters)]
        // [HideInInspector][NoScaleOffset]_RiverTurbulenceMap ("Turbulence Map", 2D) = "white" {}
        // [HideInInspector]_RiverTurbulenceStr("Strength", Range(0, 1)) = 1
        // [HideInInspector]_RiverTurbulenceTime("Time", Range(-100, 100)) = 1 // ======

        [Header(Normal Parameters)]

        [NoScaleOffset]_RiverNormalMap ("Normal Map", 2D) = "white" {}  //With derivative map instead of normal map.
        _RiverNormalStr("Normal Map Strength", Range(0, 1)) = 1

        _RiverNormalTileX("Tile X", Range(0, 100)) = 1
        _RiverNormalTileY("Tile Y", Range(0, 100)) = 1

        [HideInInspector][NoScaleOffset]_RiverDetailNormalMap ("Normal Detail Map", 2D) = "white" {}
        [HideInInspector]_RiverDetailNormalStr("Normal Detail Map Strength", Range(0, 2)) = 1
        [HideInInspector]_RiverDetailNormalTile("Normal Detail Map Tile", Range(0.2, 10)) = 1
        _RiverNormalDistantFade("Normal Distant Fade", Range(0, 2)) = 1


        [Header(Flow Map Parameters)]

        [NoScaleOffset]_RiverFlowMap ("Flow Map", 2D) = "white" {}
        _RiverFlowMapStr("Strength", Range(0, 1)) = 1
        _RiverFlowMapTime("Time", Range(-200, 200)) = 1

        [Header(AntiTiling Parameters)]

        _ATHexSize("Hexagon Size", Range(0.1, 100)) = 1.3
        _ATEdgeContrast("Edge Contrast", Range(0.01, 100)) = 1.3
        _ATScaleMin("Scale Min", Range(0, 10)) = 0.8
        _ATScaleMax("Scale Max", Range(0, 10)) = 1.8

        [Header(Wave Parameters)]

        _RiverSineAmp("Amp", Range(-5, 5)) = 1
        _RiverSineLength("Length", Range(0, 2500)) = 1
        _RiverSineTime("Speed", Range(-10, 10)) = 1

        [Header(Reflection Parameters)]

        [NoScaleOffset]_RiverCustomCubemap ("Custom Cubemap", Cube) = "black" {}
        _RiverReflectionAdd("Probe Reflection Add", Range(0, 5)) = 1
        _SSPRAdd("SSPR Add", Range(0, 5)) = 2
        [HideInInspector]_RiverCubeSSPRLerp("SSPR CUBE Lerp", Range(0, 1)) = 0.5
        _RiverPowerLevel("Reflection Count Strength", Range(0, 5)) = 1

        [Header(Refraction Parameters)]

        _RiverRefractionLevel("Refraction Multi", Range(0, 10)) = 1

        [Header(Foam Parameters)]

        [NoScaleOffset]_RiverBaseMap ("Albedo", 2D) = "white" { }
        _RiverTileX("Tile X", Range(0, 200)) = 1
        _RiverTileY("Tile Y", Range(0, 200)) = 1
        _RiverFoamPower("Foam Power", Range(0.1, 10)) = 1.5
        _RiverFoamStr("Foam Strength", Range(0.1, 10)) = 1
        _RiverFoamSpeed("Foam Speed", Range(0.1, 5)) = 1

        [Header(Caustic Parameters)]

        [NoScaleOffset]_CausticMap("Caustic Map", 2D) = "black" {}
        _CausticColor ("Caustic Color", Color) = (1, 1, 1, 1)
        _CausticStart("Caustic Add", Range(0, 10)) = 1.5
        _CausticDensity_X("Caustic Density", Range(0.1, 3)) = 1.5
        _CausticDensity_Y("Caustic Power", Range(0.1, 2.5)) = 1.5
        _CausticNormal("Caustic Normal Effect", Range(0.01, 0.5)) = 0.03
        _CausticSpeed("Caustic Speed", Range(0.1, 1)) = 0.2

        // [EndBlock]
        
    }

    HLSLINCLUDE

    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "TextureTilingRandomization.hlsl"
    // #include "WaterCommon.hlsl"

    ENDHLSL

    SubShader
    {
        Tags { "RenderType"="transparent" "Queue"="Transparent" "IgnoreProjector"="True"}
        // Tags { "RenderType"="Opaque" "Queue"="Geometry" "IgnoreProjector"="True"}

        HLSLINCLUDE
        // #pragma target 4.5
        ENDHLSL

        Pass
        {
            Name "Forward"
            Tags {"LightMode" = "UniversalForward"}

            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha

            HLSLPROGRAM

            #pragma vertex VERT
            #pragma fragment FRAG

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _SHADOWS_SOFT

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitForwardPass.hlsl"

            CBUFFER_START(UnityPerMaterial)

                float4   _RiverBaseMap_ST;
                // float4   _RiverBaseColor;
                float4   _RiverAbsorption0;
                float4   _RiverScattering0;
                float4   _RiverAbsorption1;
                float4   _RiverScattering1;
                float4   _CausticColor;
                float4   _CameraOpaqueTexture_TexelSize;
                
                half    _RiverNormalStr;
                half    _RiverDetailNormalStr;
                half    _RiverDetailNormalTile;
                half    _RiverFlowMapStr;
                half    _RiverFlowMapTime;
                half    _RiverTurbulenceTime;
                half    _RiverTurbulenceStr;
                half    _CausticSpeed;
                half    _CausticNormal;
                half    _RiverIndirectShadow;
                half    _RiverDirectShadow;
                half    _RiverAbsorption0_Num;
                half    _RiverSSSShadow;
                half    _RiverSSSShadow2;
                half    _RiverSSSShadow3;
                half    _AbsorptionC;
                half    _RiverSSPRShadow;
                half    _RiverSmothnessStr;

                half _ATScaleMax;
                half _ATScaleMin;
                half _ATEdgeContrast;
                half _ATHexSize;

                half _RiverSmothness;
                half _RiverSSSMulti;
                half _RiverDepthMulti;
                half _RiverNormalDistantFade;
                half _RefleFresnelPower;
                half _RiverReflectionAdd;
                half _RiverCubeSSPRLerp;
                half _RiverPowerLevel;
                half _RiverRefractionLevel;
                half _RiverIndirectStr;

                half _RiverTileX;
                half _RiverTileY;
                half _RiverFoamPower;
                half _RiverFoamStr;
                half _CausticStart;
                half _CausticDensity_X;
                half _CausticDensity_Y;
                half _RiverNormalTileX;
                half _RiverNormalTileY;
                half _RiverFoamSpeed;
                half _SSPRAdd;

                half _RiverSineTime;
                half _RiverSineLength;
                half _RiverSineAmp;

            CBUFFER_END

            TEXTURE2D(_RiverBaseMap); SAMPLER(sampler_RiverBaseMap);
            TEXTURE2D(_RiverNormalMap); SAMPLER(sampler_RiverNormalMap);
            TEXTURE2D(_RiverDetailNormalMap); SAMPLER(sampler_RiverDetailNormalMap);
            TEXTURE2D(_RiverFlowMap); SAMPLER(sampler_RiverFlowMap);
            TEXTURE2D(_RiverTurbulenceMap); SAMPLER(sampler_RiverTurbulenceMap);
            TEXTURE2D(_RiverDepthMap); SAMPLER(sampler_RiverDepthMap);
            
            TEXTURE2D(_SSPRReflectionResult); SAMPLER(sampler_SSPRReflectionResult);
            TEXTURE2D(_CameraOpaqueTexture); SAMPLER(sampler_CameraOpaqueTexture_linear_clamp);
            TEXTURECUBE(_RiverCustomCubemap);  SAMPLER(sampler_RiverCustomCubemap);
            TEXTURE2D(_CausticMap); SAMPLER(sampler_CausticMap);
            TEXTURE2D(_CameraDepthTexture); SAMPLER(sampler_ScreenTextures_linear_clamp);

            ///////////////////////////////////////////////////////////////////////////////
            //          	   	      Water shading functions                            //
            ///////////////////////////////////////////////////////////////////////////////

            float2 RiverDistortionUV(float depth, float3 N)
            {
                float3 VN = mul(UNITY_MATRIX_VP, -N).xyz;
                VN.xz *= saturate((depth) * 0.005);
                return VN.xz;
            }

            float3 RiverReflections(float3 normalWS, half3 viewDirectionWS, half2 screenUV, half roughness, half ProbeReflectionAdd, half SSPRAdd, half CubeSSPRLerp, float3 normalCUBE)
            {
                float3 SSPRreflection = SAMPLE_TEXTURE2D_LOD(_SSPRReflectionResult, sampler_SSPRReflectionResult, screenUV, 6 * roughness).xyz;
                float3 reflectVector = normalize(reflect(-viewDirectionWS, normalCUBE));
                float3 Cubereflection = SAMPLE_TEXTURECUBE(_RiverCustomCubemap, sampler_RiverCustomCubemap, reflectVector).xyz;

                float3 SSPRmin = min(min(SSPRreflection.r, SSPRreflection.g), SSPRreflection.b);
                half  reflectionMask = 1 - step(SSPRmin, 0);
                half  reflectionProbeMask = 1 - reflectionMask;
                float3 reflection = reflectionMask * SSPRreflection * SSPRAdd + reflectionProbeMask * Cubereflection * ProbeReflectionAdd;
                // half3 reflection = lerp(reflection, max(reflection, reflectionProbeMask * Cubereflection * ProbeReflectionAdd), CubeSSPRLerp);

                return reflection;
                // return reflection * fresnelTerm;
            }

            float3 Scattering(float depth, float3 colorA, float3 colorB)
            {
                depth = saturate(depth / 75);
                float3 color = lerp(colorA, colorB, depth);
                return color;
            }

            float3 Absorption(float depth, float3 colorA, float3 colorB)
            {
                depth = saturate(depth / 50);
                float3 color = lerp(colorA, colorB, depth);
                return color;
            }

            float3 Refraction(float2 distortion, float depth, half depthMulti, float3 colorA, float3 colorB, float2 AData)
            {
                float3 output = SAMPLE_TEXTURE2D_LOD(_CameraOpaqueTexture, sampler_CameraOpaqueTexture_linear_clamp, distortion, 0).xyz;
                output = output * Absorption(depth * (100 - depthMulti), colorA, colorB);
                return output;
            }

            float3 NormalInTBN(float3 UnpackNormal, float3 T, float3 B, float3 NormalWS, half NormalStr)
            {
                float3 output;
                output = normalize(UnpackNormal.x * NormalStr * T + UnpackNormal.y * NormalStr * B + UnpackNormal.z * NormalWS);
                return output;
            }

            // float3 ComputeRiverNoise( float3 positionWS)
            // {
            //     float2 uv = float2( positionWS.x, positionWS.z ) * 1 * 0.04 + _Time.xx / 3;
            //     // uv.x *= 0.4;
            //     float noise = SAMPLE_TEXTURE2D_LOD(_RiverBaseMap, sampler_RiverBaseMap, uv, 4).r;
            //     return noise.xxx;
            // }

            ///////////////////////////////////////////////////////////////////////////////
            //               	   Vertex and Fragment functions                         //
            ///////////////////////////////////////////////////////////////////////////////

            struct a2v
            {
                float4 position:     POSITION;
                float4 normal:       NORMAL;
                float3 texCoord:     TEXCOORD;
                float4 tangent:      TANGENT;
            };

            struct v2f
            {
                float4 positionCS:   SV_POSITION;
                float4 texcoord:     TEXCOORD0;
                float3 normalWS:     NORMAL;
                float3 tangentWS:    TANGENT;
                float3 bitangentWS:  TEXCOORD1;
                float3 pos:          TEXCOORD2;
                float4 screenPos:    TEXCOORD3;
            };

            v2f VERT(a2v i)
            {
                v2f o;

                i.position.x = i.position.x + _RiverSineAmp * sin(_RiverSineLength * i.position.x + _Time.y * _RiverSineTime);
                i.position.y = i.position.y + _RiverSineAmp * sin(_RiverSineLength * i.position.y + _Time.y * _RiverSineTime);
                i.position.z = i.position.z + _RiverSineAmp * sin(_RiverSineLength * i.position.z + _Time.y * _RiverSineTime);

                // i.normal.x = i.normal.x + _RiverSineAmp * sin(_RiverSineLength * i.normal.x + _Time.y * _RiverSineTime);
                // i.normal.y = i.normal.y + _RiverSineAmp * sin(_RiverSineLength * i.normal.y + _Time.y * _RiverSineTime);
                // i.normal.z = i.normal.z + _RiverSineAmp * sin(_RiverSineLength * i.normal.z + _Time.y * _RiverSineTime);

                o.positionCS   = TransformObjectToHClip(i.position.xyz);
                o.texcoord.xy  = TRANSFORM_TEX(i.texCoord.xy, _RiverBaseMap);
                o.normalWS     = normalize(TransformObjectToWorldNormal(i.normal.xyz));
                o.tangentWS    = normalize(TransformObjectToWorldDir(i.tangent.xyz));
                o.bitangentWS  = cross(o.normalWS, o.tangentWS);
                o.pos          = TransformObjectToWorld(i.position.xyz);
                o.screenPos    = ComputeScreenPos(o.positionCS);

                return o;
            }

            real4 FRAG(v2f i): SV_TARGET
            {

                float3 RiverBaseColor = SAMPLE_TEXTURE2D(_RiverBaseMap, sampler_RiverBaseMap, i.texcoord).xyz;
                float2 RiverBaseTile = float2(i.texcoord.x * _RiverTileX, i.texcoord.y * _RiverTileY);

                // =====================
                // === Lighting Area ===
                // =====================
                float4 SHADOW_COORDS = TransformWorldToShadowCoord(i.pos);
                Light mainLight = GetMainLight(SHADOW_COORDS);
                half Shadow = mainLight.shadowAttenuation;

                // =================
                // === Flow Area ===
                // =================

                float3 T = normalize(i.tangentWS);
                float3 B = 1 * normalize(i.bitangentWS); // DX normal inverse

                float4 RiverFlowDir = SAMPLE_TEXTURE2D(_RiverFlowMap, sampler_RiverFlowMap, i.texcoord);
                float4 RiverFlowDir_Tur = SAMPLE_TEXTURE2D(_RiverFlowMap, sampler_RiverFlowMap, i.texcoord);

                // RiverFlowDir.g = 1 - RiverFlowDir.g; 
                // flowmap baked from houdini need this, except toggle the "Inverse G" in houdini
                
                RiverFlowDir.xy = RiverFlowDir.xy * 2 - 1;
                RiverFlowDir.xy = RiverFlowDir.xy * _RiverFlowMapStr;

                RiverFlowDir_Tur.xy = RiverFlowDir_Tur.xy * 2 - 1;
                RiverFlowDir_Tur.xy = RiverFlowDir_Tur.xy * _RiverFlowMapStr;

                // inverse G
                RiverFlowDir.xyz *= float3(1, -1, 1);
                RiverFlowDir_Tur.xyz *= float3(1, -1, 1);
                
                float phase0 = frac(_Time * 0.1 * _RiverFlowMapTime);
                float phase1 = frac(_Time * 0.1 * _RiverFlowMapTime + 0.5);
                float phase2 = frac(_Time * 0.1 * _RiverTurbulenceTime);
                float phase3 = frac(_Time * 0.1 * _RiverTurbulenceTime + 0.5);
                
                half FlowLerp = abs((0.5 - phase0) / 0.5);
                half FlowLerp_Tur = abs((0.5 - phase2) / 0.5);

                // ===================
                // === Normal Area ===
                // ===================

                float4 Flowtex0 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileX + RiverFlowDir.xy * phase0);
                float4 Flowtex1 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileY + RiverFlowDir.xy * phase1);
                float4 FlowtexTur_0 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileX * 5 + RiverFlowDir_Tur.xy * phase2);
                float4 FlowtexTur_1 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileY * 5 + RiverFlowDir_Tur.xy * phase3);
                float4 FlowtexReflec0 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileX / 10 + RiverFlowDir.xy * phase0 / 5);
                float4 FlowtexReflec1 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileY / 10 + RiverFlowDir.xy * phase1 / 5);

                half RiverFlowNormalStr = _RiverNormalStr * (1 - RiverFlowDir.a);
                half RiverFlowTurStr = _RiverTurbulenceStr * RiverFlowDir.a * RiverFlowDir_Tur.a;
                half RiverReflecNormalStr = RiverFlowNormalStr / 50 + 0.005;

                // flowmap normal
                float3 Unpack_Flowtex0 = UnpackNormalScale(Flowtex0, RiverFlowNormalStr);
                float3 Unpack_Flowtex1 = UnpackNormalScale(Flowtex1, RiverFlowNormalStr);
                float3 Unpack_Flowtex0_2 = NormalInTBN(Unpack_Flowtex0, T, B, i.normalWS, RiverFlowNormalStr);
                float3 Unpack_Flowtex1_2 = NormalInTBN(Unpack_Flowtex1, T, B, i.normalWS, RiverFlowNormalStr);

                // tur normal
                float3 Unpack_FlowtexTur0 = UnpackNormalScale(FlowtexTur_0, RiverFlowTurStr * 25);
                float3 Unpack_FlowtexTur1 = UnpackNormalScale(FlowtexTur_1, RiverFlowTurStr * 25);
                float3 Unpack_FlowtexTur0_2 = NormalInTBN(Unpack_FlowtexTur0, T, B, i.normalWS, RiverFlowTurStr * 25);
                float3 Unpack_FlowtexTur1_2 = NormalInTBN(Unpack_FlowtexTur1, T, B, i.normalWS, RiverFlowTurStr * 25);

                // refelction normal
                float3 Unpack_Flowtex0_Reflec = UnpackNormalScale(FlowtexReflec0, RiverFlowNormalStr);
                float3 Unpack_Flowtex1_Reflec = UnpackNormalScale(FlowtexReflec1, RiverFlowNormalStr);
                float3 Unpack_Flowtex0_Reflec_2 = NormalInTBN(Unpack_Flowtex0_Reflec, T, B, i.normalWS, RiverFlowNormalStr);
                float3 Unpack_Flowtex1_Reflec_2 = NormalInTBN(Unpack_Flowtex1_Reflec, T, B, i.normalWS, RiverFlowNormalStr);

                // cubemap normal
                float3 Unpack_Cube00 = UnpackNormalScale(Flowtex0, RiverFlowNormalStr / 11);
                float3 Unpack_Cube01 = UnpackNormalScale(Flowtex1, RiverFlowNormalStr / 11);
                float3 Unpack_Cube0 = NormalInTBN(Unpack_Cube00, T, B, i.normalWS, RiverFlowNormalStr / 11);
                float3 Unpack_Cube1 = NormalInTBN(Unpack_Cube01, T, B, i.normalWS, RiverFlowNormalStr / 11);

                float3 CubeReflecNormal = normalize(lerp(Unpack_Cube0, Unpack_Cube1, FlowLerp));
                float3 FlowRiverNormal = normalize(lerp(Unpack_Flowtex0_2, Unpack_Flowtex1_2, FlowLerp));
                float3 FlowRiverTurNormal = normalize(lerp(Unpack_FlowtexTur0_2, Unpack_FlowtexTur1_2, FlowLerp_Tur));
                float3 FlowRiverRefrac = normalize(lerp(Unpack_Flowtex0, Unpack_Flowtex1, FlowLerp));
                float3 FlowRiverReflec = normalize(lerp(Unpack_Flowtex0_Reflec_2, Unpack_Flowtex1_Reflec_2, FlowLerp));

                float3 FlowFinalNormal = normalize(float3(FlowRiverNormal.xy + FlowRiverTurNormal.xy, FlowRiverNormal.z));

                // =====================
                // === Foam Hex Area ===
                // =====================

                // Hexagon Foam Flow
                float3 FoamHexagonResult_1 = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), RiverBaseTile + RiverFlowDir.xy * phase0 * _RiverFoamSpeed, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax).xyz;
                float3 FoamHexagonResult_2 = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), RiverBaseTile + RiverFlowDir.xy * phase1 * _RiverFoamSpeed, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax).xyz;
                FoamHexagonResult_1 *= RiverFlowDir.a;
                FoamHexagonResult_2 *= RiverFlowDir.a;
                float3 FlowFoam = lerp(FoamHexagonResult_1, FoamHexagonResult_2, FlowLerp);
                FlowFoam = pow(FlowFoam, _RiverFoamPower) * _RiverFoamStr;
                FlowFoam = FlowFoam * (1 - Shadow) * 0.3 + FlowFoam * Shadow;

                // distance blend
                float distanceBlend = saturate(abs(length((_WorldSpaceCameraPos.xz - i.pos.xz) * 0.015)) - _RiverNormalDistantFade / 4);
                // FlowFinalNormal = lerp(FlowFinalNormal, i.normalWS, 1 - distanceBlend);
                
                // ===================
                // === Anti Tiling ===
                // ===================

                float4 HexagonResult = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), i.texcoord.xy, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax);

                // ===========================
                // === Math Operation Area ===
                // ===========================
                float3 N = normalize(FlowFinalNormal);
                float3 L = normalize(mainLight.direction);
                float3 V = normalize(_WorldSpaceCameraPos.xyz - i.pos.xyz);
                float3 H = normalize(V + L);
                float3 R = normalize(reflect(-V, N));

                float NoV = max(saturate(dot(N, V)), 0.001f);
                float NoL = max(saturate(dot(N, L)), 0.001f);
                float HoV = max(saturate(dot(H, V)), 0.001f);
                float NoH = max(saturate(dot(H, N)), 0.001f);
                float LoH = max(saturate(dot(H, L)), 0.001f);

                float NoLModify = saturate(1 - NoL + 0.3);

                // ==========================
                // === Depth & Distortion ===
                // ==========================
                
                float Fresnel = pow((1.0 - saturate(dot(i.normalWS, V))), _RefleFresnelPower);
                float FresnelHD = pow((1.0 - saturate(dot(N, V))), _RefleFresnelPower);

                float FresnelHDReflec = pow((1.0 - saturate(dot(N, V))), saturate(_RefleFresnelPower - 3));
                
                half2 AdditionalData = half2(0.0, 0.0);
                AdditionalData.x = length(TransformWorldToView(i.pos.xyz) / TransformWorldToView(i.pos.xyz).z);// distance to surface
                AdditionalData.y = length(_WorldSpaceCameraPos.xyz - i.pos.xyz); // local position in camera space

                float4 ScreenPosOrg = i.screenPos;
                i.screenPos.xy /= i.screenPos.w;

                float RawDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_ScreenTextures_linear_clamp, i.screenPos);
                RawDepth = LinearEyeDepth(RawDepth, _ZBufferParams); // Raw depth
                float AdjustDepth = RawDepth * AdditionalData.x - AdditionalData.y; // combine depth with camera's height and camera position to vertex distant.

                float DepthMapVar = SAMPLE_TEXTURE2D(_RiverDepthMap, sampler_RiverDepthMap, i.texcoord) * 2 - 1; // Adjust depth by baked depth.
                
                float2 distortion = RiverDistortionUV(RawDepth.x, N);
                distortion = i.screenPos.xy + distortion * saturate(_RiverNormalDistantFade - pow(Fresnel, 0.5));
                distortion = RawDepth.x < 0 ? i.screenPos.xy : distortion;

                float2 distortionReflec = RiverDistortionUV(RawDepth.x, FlowRiverReflec);
                distortionReflec = i.screenPos.xy + distortionReflec * (saturate(1 - FresnelHD) * 2 - 0.3);
                distortionReflec = RawDepth.x < 0 ? i.screenPos.xy : distortionReflec;

                half RiverRefractionLevel = _RiverRefractionLevel * saturate(1.1 - distanceBlend - _RiverNormalDistantFade);

                float surfaceDepth = UNITY_Z_0_FAR_FROM_CLIPSPACE(ScreenPosOrg.z);
                float backgroundDepth = RawDepth;
                float differentDepth = backgroundDepth - surfaceDepth;

                float2 HoleUV;
                HoleUV = (ScreenPosOrg.xy +  FlowRiverRefrac.xy / 10 * RiverRefractionLevel * 2) / ScreenPosOrg.w;
                HoleUV.x = ScreenPosOrg.x / ScreenPosOrg.w;

                float HoleDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_ScreenTextures_linear_clamp, HoleUV); // Fill depth artifact  near edges
                HoleDepth = LinearEyeDepth(HoleDepth, _ZBufferParams); 
                differentDepth = HoleDepth - RawDepth;

                HoleUV.y = differentDepth < 0 ? i.screenPos.y : HoleUV.y;

                // ===================
                // === Direct Area ===
                // ===================

                float RiverSmothness = _RiverSmothness;
                
                BRDFData brdfData;
                float inoutAlpha = 1.0;
                InitializeBRDFData(0, 0, half3(1, 1, 1), RiverSmothness, inoutAlpha, brdfData);

                BRDFData brdfData2;
                InitializeBRDFData(0, 0, half3(1, 1, 1), saturate(RiverSmothness - 0.05), inoutAlpha, brdfData2);
                // BaseColor, metallic, specular, Smoothness, alpha, brdfData;

                // if shader code except "l-value specifies const object", change InitializeBRDFData to below, 1.0 to "inoutAlpha"
                // InitializeBRDFData(0, 0, half3(1, 1, 1), saturate(RiverSmothness - 0.05), 1.0, brdfData2);
                
                float3 spec = DirectBDRF(brdfData, N, L, V) * Shadow;
                float3 spec2 = DirectBDRF(brdfData2, N, L, V) * Shadow;

                spec /= 15; // URP don't have TAA, aviod specular fliker
                spec2 /= 15;

                spec = spec + spec2;
                spec = spec * saturate(AdjustDepth + _RiverSSSShadow3 - 0.4);
                float3 GI = SampleSH(N);

                float3 sss = _RiverSSSMulti * (mainLight.color + GI);
                sss = sss * Scattering(AdjustDepth.x * _RiverDepthMulti, _RiverScattering0, _RiverScattering1);
                sss = sss * (1 - Shadow) * _RiverSSSShadow * saturate(AdjustDepth + _RiverSSSShadow2) + sss * Shadow;

                // ====================
                // === Caustic Area ===
                // ====================

                // Caustic 2, from eggahce shader graph.
                float3 CausticworldPos = ComputeWorldSpacePosition(i.screenPos, (SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_ScreenTextures_linear_clamp, i.screenPos)), UNITY_MATRIX_I_VP);
                uint Causticscale = 1;
                uint3 worldIntPos = uint3(abs(CausticworldPos.xyz * Causticscale));

                float2 Caustic_5 = CausticworldPos.xz;
                float2 Caustic_6 = FlowFinalNormal.xz;

                Caustic_5 = float2(_CausticDensity_X , _CausticDensity_X) * Caustic_5;
                Caustic_6 = float2(_CausticNormal, _CausticNormal) * Caustic_6;
                float2 Caustic_7 = Caustic_5 + Caustic_6;
                float2 Caustic_8 = Caustic_7 + _Time * _CausticSpeed;
                float2 Caustic_8_2 = Caustic_7 * 0.91382 - _Time * _CausticSpeed * 0.77432;

                float CausticMap_Modi = (pow(RiverFlowDir.a + _CausticStart, _CausticDensity_Y));

                float3 CausticMap_2 = SAMPLE_TEXTURE2D(_CausticMap, sampler_CausticMap, Caustic_8) * CausticMap_Modi * _CausticColor;
                float3 CausticMap_3 = SAMPLE_TEXTURE2D(_CausticMap, sampler_CausticMap, Caustic_8_2) * CausticMap_Modi * _CausticColor;
                float3 CausticMap_Fin = min(CausticMap_2, CausticMap_3) * Shadow * RiverFlowDir.b;

                // ====================
                // === WetEdge Area ===
                // ====================

                // =====================
                // === Indirect Area ===
                // =====================

                float3 indirect = SAMPLE_TEXTURECUBE_LOD(_RiverCustomCubemap, sampler_RiverCustomCubemap, R, 4);
                indirect *=  _RiverIndirectStr / 3;

                indirect = indirect * (1 - Shadow) * _RiverIndirectShadow + indirect * Shadow;

                // ==================
                // === Reflection ===
                // ==================
                float3 reflection = RiverReflections(N, V, distortionReflec, 0.0, _RiverReflectionAdd, _SSPRAdd, _RiverCubeSSPRLerp, CubeReflecNormal);
                reflection = reflection * FresnelHDReflec * _RiverPowerLevel;

                // reflection = reflection * _RiverPowerLevel * 0.5;
                // reflection = reflection * NoLModify;

                reflection = reflection * (1 - Shadow) * _RiverSSPRShadow + reflection * Shadow * saturate(AdjustDepth - _RiverSSSShadow3);

                // ==================
                // === Refraction ===
                // ==================

                float3 refraction;

                // half RiverAbsorptionCModify = 2.3 / clamp(NoLModify, 1, NoLModify);
                float3 RiverAbsorptionC = SAMPLE_TEXTURE2D_LOD(_CameraOpaqueTexture, sampler_CameraOpaqueTexture_linear_clamp, HoleUV, 0).xyz * _RiverAbsorption0_Num;
                RiverAbsorptionC = RiverAbsorptionC * (1 - Shadow) * _AbsorptionC + RiverAbsorptionC * Shadow;

                // RiverAbsorptionC = _RiverAbsorption0;
                refraction = Refraction(HoleUV, AdjustDepth.x, _RiverDepthMulti, RiverAbsorptionC, _RiverAbsorption1, AdditionalData);

                float3 refraction2 = Refraction(HoleUV, AdjustDepth.x, _RiverDepthMulti + 10, RiverAbsorptionC, _RiverAbsorption1 * 0.9, AdditionalData);
                float3 refraction3 = Refraction(HoleUV, AdjustDepth.x, _RiverDepthMulti + 20, RiverAbsorptionC, _RiverAbsorption1 * 0.8, AdditionalData);
                float3 refraction4 = Refraction(HoleUV, AdjustDepth.x, _RiverDepthMulti + 30, RiverAbsorptionC, _RiverAbsorption1 * 0.7, AdditionalData);
                float3 refraction5 = Refraction(HoleUV, AdjustDepth.x, _RiverDepthMulti + 40, RiverAbsorptionC, _RiverAbsorption1 * 0.1, AdditionalData);
                
                float3 refractionCount = min(min(min(min(refraction5, refraction4), refraction3), refraction2), refraction);

                float3 diffuse = (refractionCount + sss);
                diffuse = diffuse * (1 - Shadow) * _RiverDirectShadow + diffuse * Shadow;

                // ==============
                // === Result ===
                // ==============

                // float VVV = (saturate(1 - FresnelHD) * 2 - 0.3) * 3;
                
                return float4(reflection * NoL + diffuse + indirect + spec + FlowFoam + CausticMap_Fin, 1);
                // return float4(diffuse, 1); //CausticMask
                // return float4(FlowRiverNormal + float3(0.5, 0.5, 1), 1);
            }

            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            Cull[_Cull]

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature _ALPHATEST_ON

            // -------------------------------------
            // Pipeline Keywords
            #pragma multi_compile_vertex _ _ADDITIONAL_POINT_SHADOW
            #pragma multi_compile _ _DUAL_PARABOLOID

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }
    }

    // CustomEditor "UniversalVFXShaderGUI"
}