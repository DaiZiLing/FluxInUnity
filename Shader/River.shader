Shader "WorldX/Scene/River"
{
    Properties
    {
        [Header(Base Parameters)]
        [NoScaleOffset]_RiverBaseMap ("Albedo", 2D) = "white" { }
        _RiverTileX("Tile X", Range(0, 200)) = 1
        _RiverTileY("Tile Y", Range(0, 200)) = 1

        _RiverSmothness("Smothness Strength", Range(0, 1)) = 0.5
        _RiverSSSMulti("SSS Strength", Range(0, 5)) = 1
        _RiverDepthMulti("Visbity", Range(1, 100)) = 3

        _RiverScattering0 ("Scattering 0", Color) = (1, 1, 1, 1)
        _RiverScattering1 ("Scattering 1", Color) = (1, 1, 1, 1)
        _RiverAbsorption0 ("Absorption 0", Color) = (1, 1, 1, 1)
        _RiverAbsorption1 ("Absorption 1", Color) = (1, 1, 1, 1)

        _RefleFresnelPower("Fresnel Power", Range(1, 10)) = 1

        _RiverIndirectStr("Indirect Light", Range(0, 1)) = 0.1

        [Header(Normal Parameters)]
        [NoScaleOffset]_RiverNormalMap ("Normal Map", 2D) = "white" {}
        _RiverNormalStr("Normal Map Strength", Range(0, 2)) = 1

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

        [Header(Turbulence Parameters)]
        [NoScaleOffset]_RiverTurbulenceMap ("Turbulence Map", 2D) = "white" {}
        _RiverTurbulenceStr("Strength", Range(0, 1)) = 1
        _RiverTurbulenceTime("Time", Range(-100, 100)) = 1

        [Header(AntiTiling Parameters)]
        _ATHexSize("Hexagon Size", Range(0.1, 100)) = 1.3
        _ATEdgeContrast("Edge Contrast", Range(0.01, 100)) = 1.3
        _ATScaleMin("Scale Min", Range(0, 10)) = 0.8
        _ATScaleMax("Scale Max", Range(0, 10)) = 1.8

        [Header(Wave Parameters)]
        _RiverSineAmp("Amp", Range(-5, 5)) = 1
        _RiverSineLength("Length", Range(0, 500)) = 1
        _RiverSineTime("Speed", Range(-10, 10)) = 1

        [Header(Reflection Parameters)]
        [NoScaleOffset]_RiverCustomCubemap ("Custom Cubemap", Cube) = "black" {}
        _RiverReflectionAdd("Probe Reflection Add", Range(0, 5)) = 1
        _SSPRAdd("SSPR Add", Range(0, 5)) = 2
        _RiverCubeSSPRLerp("SSPR CUBE Lerp", Range(0, 1)) = 0.5
        _RiverPowerLevel("Reflection Count Strength", Range(0, 5)) = 1

        [Header(Refraction Parameters)]
        _RiverRefractionLevel("Refraction Multi", Range(0, 10)) = 1

        [Header(Foam Parameters)]
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
    }

    HLSLINCLUDE

    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "TextureTilingRandomization.hlsl"

    ENDHLSL

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent" "IgnoreProjector"="True"}
        // Tags { "RenderType"="Opaque" "Queue"="Geometry" "IgnoreProjector"="True"}

        HLSLINCLUDE
        // #pragma target 4.5
        ENDHLSL

        Pass
        {
            Name "Forward"
            // Tags {"LightMode" = "UniversalForward"}
            Tags { "LightMode"="DForward" }

            Cull Off
            // Blend SrcAlpha OneMinusSrcAlpha

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
                float4   _RiverAbsorption0;
                float4   _RiverScattering0;
                float4   _RiverAbsorption1;
                float4   _RiverScattering1;
                float4   _CausticColor;
                
                half    _RiverNormalStr;
                half    _RiverDetailNormalStr;
                half    _RiverDetailNormalTile;
                half    _RiverFlowMapStr;
                half    _RiverFlowMapTime;
                half    _RiverTurbulenceTime;
                half    _RiverTurbulenceStr;
                half    _CausticSpeed;
                half    _CausticNormal;

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

            ///////////////////////////////////////////////////////////////////////////////
            //          	   	      Water shading functions                            //
            ///////////////////////////////////////////////////////////////////////////////

            half2 RiverDistortionUV(half depth, float3 N)
            {
                half3 VN = mul(UNITY_MATRIX_VP, -N).xyz;
                VN.xy *= saturate((depth) * 0.005);
                return VN.xy;
            }

            half3 RiverReflections(half3 normalWS, half3 viewDirectionWS, half2 screenUV, half roughness, half ProbeReflectionAdd, half SSPRAdd, half CubeSSPRLerp)
            {
                half3 SSPRreflection = SAMPLE_TEXTURE2D_LOD(_SSPRReflectionResult, sampler_SSPRReflectionResult, screenUV, 6 * roughness).xyz;
                half3 reflectVector = normalize(reflect(-viewDirectionWS * float3(1, -1, -1), normalWS));
                half3 Cubereflection = SAMPLE_TEXTURECUBE(_RiverCustomCubemap, sampler_RiverCustomCubemap, reflectVector).xyz;

                half  reflectionMask = 1 - step(SSPRreflection.z, 0);
                half  reflectionProbeMask = 1 - reflectionMask;
                half3 reflection = reflectionMask * SSPRreflection * SSPRAdd + reflectionProbeMask * Cubereflection;
                reflection = lerp(reflection, max(reflection, reflectionProbeMask * Cubereflection * ProbeReflectionAdd), CubeSSPRLerp);

                return reflection;
            }

            half3 Scattering(half depth, half3 colorA, half3 colorB)
            {
                depth = saturate(depth / 75);
                half3 color = lerp(colorA, colorB, depth);
                return color;
            }

            half3 Absorption(half depth, half3 colorA, half3 colorB)
            {
                depth = saturate(depth / 50);
                half3 color = lerp(colorA, colorB, depth);
                return color;
            }

            half3 Refraction(half2 distortion, half depth, half depthMulti, half3 colorA, half3 colorB, float2 AData)
            {
                half3 output = SAMPLE_TEXTURE2D_LOD(_CameraOpaqueTexture, sampler_CameraOpaqueTexture_linear_clamp, distortion, 0).xyz;
                output *= Absorption(depth * (100 - depthMulti), colorA, colorB);
                return output;
            }

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

                i.normal.x = i.normal.x + _RiverSineAmp * sin(_RiverSineLength * i.normal.x + _Time.y * _RiverSineTime);
                i.normal.y = i.normal.y + _RiverSineAmp * sin(_RiverSineLength * i.normal.y + _Time.y * _RiverSineTime);
                i.normal.z = i.normal.z + _RiverSineAmp * sin(_RiverSineLength * i.normal.z + _Time.y * _RiverSineTime);

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

                RiverFlowDir.g = 1 - RiverFlowDir.g;
                
                RiverFlowDir.xy = RiverFlowDir.xy * 2 - 1;
                
                RiverFlowDir.xy = RiverFlowDir.xy * _RiverFlowMapStr;

                RiverFlowDir_Tur.xy = RiverFlowDir_Tur.xy * 2 - 1;
                RiverFlowDir_Tur.xy = RiverFlowDir_Tur.xy * _RiverFlowMapStr;

                RiverFlowDir.r *= 1;
                RiverFlowDir.g *= -1; // Unity inverse G channel
                RiverFlowDir.a *= 1;

                RiverFlowDir_Tur.r *= 1;
                RiverFlowDir_Tur.g *= -1;
                RiverFlowDir_Tur.a *= 1;
                
                float phase0 = frac(_Time * 0.1 * _RiverFlowMapTime);
                float phase1 = frac(_Time * 0.1 * _RiverFlowMapTime + 0.5);
                float phase2 = frac(_Time * 0.1 * _RiverTurbulenceTime);
                float phase3 = frac(_Time * 0.1 * _RiverTurbulenceTime + 0.5);

                half3 Flowtex0 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileX + RiverFlowDir.xy * phase0);
                half3 Flowtex1 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileY + RiverFlowDir.xy * phase1);

                half3 FlowtexTur_0 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileX * 1 + RiverFlowDir_Tur.xy * phase2);
                half3 FlowtexTur_1 = SAMPLE_TEXTURE2D(_RiverNormalMap, sampler_RiverNormalMap, i.texcoord * _RiverNormalTileY * 1 + RiverFlowDir_Tur.xy * phase3);

                half3 Unpack_Flowtex0 = float3((Flowtex0.xy * 2 - 1) * _RiverNormalStr * (1 - RiverFlowDir.a), 1);
                half3 Unpack_Flowtex1 = float3((Flowtex1.xy * 2 - 1) * _RiverNormalStr * (1 - RiverFlowDir.a), 1);

                half3 Unpack_FlowtexTur_0 = float3((FlowtexTur_0.xy * 2 - 1) * _RiverTurbulenceStr * RiverFlowDir_Tur.a * RiverFlowDir.a, 1);
                half3 Unpack_FlowtexTur_1 = float3((FlowtexTur_1.xy * 2 - 1) * _RiverTurbulenceStr * RiverFlowDir_Tur.a * RiverFlowDir.a, 1);

                Unpack_FlowtexTur_0 = normalize(Unpack_FlowtexTur_0);
                Unpack_FlowtexTur_1 = normalize(Unpack_FlowtexTur_1);

                float FlowLerp = abs((0.5 - phase0) / 0.5);
                float FlowLerp_Tur = abs((0.5 - phase2) / 0.5);
                half3 FlowFinalColor = lerp(Flowtex0, Flowtex1, FlowLerp);

                half3 FlowTurNormal = normalize(lerp(Unpack_FlowtexTur_0, Unpack_FlowtexTur_1, FlowLerp_Tur));
                half3 FlowRiverNormal = normalize(lerp(Unpack_Flowtex0, Unpack_Flowtex1, FlowLerp));

                half3 FlowFinalNormal = normalize(float3(FlowTurNormal.xy + FlowRiverNormal.xy, FlowRiverNormal.z));

                // Hexagon Foam Flow
                float3 FoamHexagonResult_1 = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), RiverBaseTile + RiverFlowDir.xy * phase0 * _RiverFoamSpeed, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax).xyz;
                float3 FoamHexagonResult_2 = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), RiverBaseTile + RiverFlowDir.xy * phase1 * _RiverFoamSpeed, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax).xyz;
                FoamHexagonResult_1 *= RiverFlowDir.a;
                FoamHexagonResult_2 *= RiverFlowDir.a;
                half3 FlowFoam = lerp(FoamHexagonResult_1, FoamHexagonResult_2, FlowLerp);
                FlowFoam = pow(FlowFoam, _RiverFoamPower) * _RiverFoamStr;

                // ===================
                // === Normal Area ===
                // ===================

                // distance blend
                half distanceBlend = saturate(abs(length((_WorldSpaceCameraPos.xz - i.pos.xz) * 0.015)) - 0.25);

                // ===================
                // === Anti Tiling ===
                // ===================

                float4 HexagonResult = SampleTextureRandomizedHexGridMM\
                (TEXTURE2D_ARGS(_RiverBaseMap, sampler_RiverBaseMap), i.texcoord.xy, _ATHexSize, _ATEdgeContrast, _ATScaleMin, _ATScaleMax);

                // Anti Tiling Normal
                float3 unpack_Hexagon_normal  = UnpackNormalScale(HexagonResult, _RiverNormalStr);
                float3 Hexagon_normal = normalize\
                (unpack_Hexagon_normal.x * _RiverNormalStr * T + unpack_Hexagon_normal.y * _RiverNormalStr * B + 1 * i.normalWS);

                // ===========================
                // === Math Operation Area ===
                // ===========================
                float3 N = normalize(FlowFinalNormal);
                float3 L = normalize(mainLight.direction);
                float3 V = normalize(_WorldSpaceCameraPos.xyz - i.pos.xyz);
                float3 H = normalize(V + L);
                float3 R = normalize(reflect(-V, N));

                float NoV = max(saturate(dot(N, V)), 0.001f);
                float NoL = max(saturate(dot(N, -L)), 0.001f);
                float HoV = max(saturate(dot(H, V)), 0.001f);
                float NoH = max(saturate(dot(H, N)), 0.001f);
                float LoH = max(saturate(dot(H, L)), 0.001f);

                // ==========================
                // === Depth & Distortion ===
                // ==========================
                
                float Fresnel = pow((1.0 - saturate(dot(i.normalWS, V))), _RefleFresnelPower);
                
                half2 AdditionalData = half2(0.0, 0.0);
                AdditionalData.x = length(TransformWorldToView(i.pos.xyz) / TransformWorldToView(i.pos.xyz).z);// distance to surface
                AdditionalData.y = length(_WorldSpaceCameraPos.xyz - i.pos.xyz); // local position in camera space

                // Sorry, cuz this shader is used in my Custom pipeline.
                // here may occur error in URP, you may need to get a correct Screen UV depth in URP
                ModelData data = ModelDataFromMRT(i.texcoord); 
                i.screenPos.xy /= i.screenPos.w;

                float RawDepth = CommonSampleDepth(i.screenPos);
                RawDepth = LinearEyeDepth(RawDepth, _ZBufferParams); // Raw depth
                float AdjustDepth = RawDepth * AdditionalData.x - AdditionalData.y; // combine depth with camera's height and camera position to vertex distant.

                float DepthMapVar = SAMPLE_TEXTURE2D(_RiverDepthMap, sampler_RiverDepthMap, i.texcoord) * 2 - 1; // Adjust depth by baked depth.

                float3 OutDepth = 0;
                OutDepth.xz = float2(AdjustDepth, 0);
                OutDepth.y = i.pos.y;
                
                half2 distortion = RiverDistortionUV(RawDepth.x, N);
                distortion = i.screenPos.xy + distortion * saturate(_RiverNormalDistantFade - pow(Fresnel, 0.5));
                distortion = RawDepth.x < 0 ? i.screenPos.xy : distortion;

                half2 distortionReflec = RiverDistortionUV(RawDepth.x, N);
                distortionReflec = i.screenPos.xy + distortionReflec * saturate(_RiverNormalDistantFade + 0.6 - pow(Fresnel, 0.5));
                distortionReflec = RawDepth.x < 0 ? i.screenPos.xy : distortionReflec;

                _RiverRefractionLevel = _RiverRefractionLevel * saturate(0.6 - distanceBlend - _RiverNormalDistantFade);
                half2 distortionRefraction = _RiverRefractionLevel * RiverDistortionUV(RawDepth.x, N);

                distortionRefraction = i.screenPos.xy + distortionRefraction * saturate(_RiverNormalDistantFade - pow(Fresnel, 0.5));

                // distortionRefraction = float2(i.screenPos.x + sin(i.screenPos.y * 100)*0.01, i.screenPos.y));
                distortionRefraction = RawDepth.x < 0 ? i.screenPos.xy : distortionRefraction;

                float RawDepth_2 = CommonSampleDepth(distortion);
                RawDepth_2 = LinearEyeDepth(RawDepth_2, _ZBufferParams); // Raw depth after distortion, sample the depth again with distortion uv.
                float AdjustDepth_2 = RawDepth_2 * AdditionalData.x - AdditionalData.y;

                AdjustDepth_2.x = AdjustDepth_2.x < 0 ? AdjustDepth : AdjustDepth_2.x; // fill the depth hole in depth_2

                // ===================
                // === Direct Area ===
                // ===================

                float3 RiverDirectColor = FlowFinalColor * PI * mainLight.color * 0.25;
                
                BRDFData brdfData;
                InitializeBRDFData(0, 0, half3(1, 1, 1), _RiverSmothness, 1, brdfData);
                // BaseColor, metallic, specular, Smoothness, alpha, brdfData;
                
                half3 spec = DirectBDRF(brdfData, N.rbg, L, V) * mainLight.color * Shadow;
                spec /= 50;
                half3 GI = SampleSH(N.rgb);

                half3 sss = _RiverSSSMulti * (mainLight.color + GI);
                sss *= Scattering(AdjustDepth_2.x * _RiverDepthMulti, _RiverScattering0, _RiverScattering1);

                // ====================
                // === Caustic Area ===
                // ====================

                float3 CausticworldPos = ComputeWorldSpacePosition(i.screenPos, CommonSampleDepth(i.screenPos), UNITY_MATRIX_I_VP);
                uint Causticscale = 1;
                uint3 worldIntPos = uint3(abs(CausticworldPos.xyz * Causticscale));

                float2 Caustic_5 = CausticworldPos.xz;
                float2 Caustic_6 = FlowFinalNormal.xz;

                Caustic_5 = float2(_CausticDensity_X , _CausticDensity_X) * Caustic_5;
                Caustic_6 = float2(_CausticNormal, _CausticNormal) * Caustic_6;
                float2 Caustic_7 = Caustic_5 + Caustic_6;
                float2 Caustic_8 = Caustic_7 + _Time * _CausticSpeed;
                float2 Caustic_8_2 = Caustic_7 * 0.91382 - _Time * _CausticSpeed * 0.87432;

                float CausticMap_Modi = (pow(RiverFlowDir.a + _CausticStart, _CausticDensity_Y));

                half3 CausticMap_2 = SAMPLE_TEXTURE2D(_CausticMap, sampler_CausticMap, Caustic_8) * CausticMap_Modi * _CausticColor;
                half3 CausticMap_3 = SAMPLE_TEXTURE2D(_CausticMap, sampler_CausticMap, Caustic_8_2) * CausticMap_Modi * _CausticColor;
                half3 CausticMap_Fin = min(CausticMap_2, CausticMap_3) * Shadow;

                // ====================
                // === WetEdge Area ===
                // ====================

                // =====================
                // === Indirect Area ===
                // =====================

                half3 indirect = SAMPLE_TEXTURECUBE_LOD(_RiverCustomCubemap, sampler_RiverCustomCubemap, R, 4) * _RiverIndirectStr / 3;

                // ==================
                // === Reflection ===
                // ==================
                half3 reflection = RiverReflections(N, V, distortionReflec, 0.0, _RiverReflectionAdd, _SSPRAdd, _RiverCubeSSPRLerp) * Fresnel * _RiverPowerLevel;

                // ==================
                // === Refraction ===
                // ==================

                half3 refraction;
                refraction = Refraction(distortionRefraction, AdjustDepth_2.x, _RiverDepthMulti, _RiverAbsorption0, _RiverAbsorption1, AdditionalData);

                half3 diffuse = (refraction + sss);

                // ==============
                // === Result ===
                // ==============

                return float4(reflection + spec + diffuse + indirect + FlowFoam + CausticMap_Fin, 1);
                // return float4(reflection, 1); //CausticMask
                // return float4(FlowFinalNormal + float3(0.5, 0.5, 1), 1);
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
}