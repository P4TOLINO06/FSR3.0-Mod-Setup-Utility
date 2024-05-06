// ---- FNV Hash c2bd7f53b0bb3b25

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer water_globals : register(b4)
{
  float2 gWorldBaseVS : packoffset(c0);
  float4 gFlowParams : packoffset(c1);
  float4 gFlowParams2 : packoffset(c2);
  float4 gWaterAmbientColor : packoffset(c3);
  float4 gWaterDirectionalColor : packoffset(c4);
  float4 gScaledTime : packoffset(c5);
  float4 gOceanParams0 : packoffset(c6);
  float4 gOceanParams1 : packoffset(c7);
  row_major float4x4 gReflectionWorldViewProj : packoffset(c8);
  float4 gFogLight_Debugging : packoffset(c12);
  row_major float4x4 gRefractionWorldViewProj : packoffset(c13);
  float4 gOceanParams2 : packoffset(c17);
}

cbuffer water_locals : register(b11)
{
  float4 OceanLocalParams0 : packoffset(c0);
  float4 FogParams : packoffset(c1);
  float4 QuadAlpha : packoffset(c2);
  float3 CameraPosition : packoffset(c3);
}

SamplerState ReflectionSampler_s : register(s1);
SamplerState StaticBumpSampler_s : register(s2);
SamplerState FogSampler_s : register(s3);
SamplerState BlendSampler_s : register(s6);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> StaticBumpSampler : register(t2);
Texture2D<float4> FogSampler : register(t3);
Texture2D<float4> BlendSampler : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r1.x = sqrt(r0.w);
  r0.w = rsqrt(r0.w);
  r1.y = 22000 + -r1.x;
  r1.y = cmp(r1.y < 0);
  if (r1.y != 0) discard;
  r1.y = 0.100000001 * gScaledTime.x;
  r1.zw = v3.yx * float2(0.00223214296,0.00223214296) + r1.yy;
  r2.xy = v3.xy * float2(0.001953125,0.001953125) + -r1.yy;
  r2.xyzw = StaticBumpSampler.Sample(StaticBumpSampler_s, r2.xy).xyzw;
  r2.xy = r2.wy * float2(2,2) + float2(-1,-1);
  r3.xyzw = StaticBumpSampler.Sample(StaticBumpSampler_s, r1.zw).xyzw;
  r1.yz = r3.yw * float2(2,2) + float2(-1,-1);
  r1.yz = -r1.yz + -r2.xy;
  r1.yz = gOceanParams1.ww * r1.yz;
  r2.xy = gOceanParams0.xx * r1.yz;
  r2.z = 1;
  r1.y = dot(r2.xyz, r2.xyz);
  r1.y = rsqrt(r1.y);
  r3.xyz = -r2.xyz * r1.yyy + float3(0,0,1);
  r1.yzw = r2.xyz * r1.yyy;
  r2.xyz = r3.xyz * float3(0.833333313,0.833333313,0.833333313) + r1.yzw;
  r3.xyz = r0.xyz * r0.www;
  r0.xyw = r0.xyz * r0.www + gDirectionalLight.xyz;
  r2.w = dot(r3.xyz, r2.xyz);
  r2.w = r2.w + r2.w;
  r2.xyz = r2.xyz * -r2.www + r3.xyz;
  r2.xy = float2(0.25,0.5) * r2.xy;
  r2.w = 1 + abs(r2.z);
  r2.z = cmp(0 < r2.z);
  r2.xy = r2.xy / r2.ww;
  r4.yz = float2(0.25,0.5) + -r2.xy;
  r2.x = 1 + -r4.y;
  r4.x = r2.z ? r2.x : r4.y;
  r2.xyzw = ReflectionSampler.Sample(ReflectionSampler_s, r4.xz).xyzw;
  r4.xy = -FogParams.xy + v3.xy;
  r4.x = FogParams.z * r4.x;
  r4.z = -r4.y * FogParams.w + 1;
  r4.xyzw = FogSampler.Sample(FogSampler_s, r4.xz).xyzw;
  r4.xyz = r4.xyz * r4.xyz;
  r2.xyz = -r4.xyz * gWaterAmbientColor.xyz + r2.xyz;
  r4.xyz = gWaterAmbientColor.xyz * r4.xyz;
  r2.w = dot(-r3.xyz, r1.yzw);
  r3.w = 1 + -r2.w;
  r2.w = r3.w * 0.300000012 + r2.w;
  r5.xyzw = BlendSampler.Sample(BlendSampler_s, r2.ww).xyzw;
  r2.xyz = r5.xxx * r2.xyz + r4.xyz;
  r2.w = dot(r0.xyw, r0.xyw);
  r2.w = rsqrt(r2.w);
  r0.xyw = r2.www * r0.xyw;
  r0.x = saturate(dot(-r0.xyw, r1.yzw));
  r0.x = log2(r0.x);
  r0.x = gOceanParams0.w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = gOceanParams0.z * r0.x;
  r0.xyw = gDirectionalColour.xyz * r0.xxx + r2.xyz;
  r1.y = -globalFogParams[0].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r0.z = r1.x * r0.z;
  r1.x = globalFogParams[2].z * r0.z;
  r0.z = cmp(0.00999999978 < abs(r0.z));
  r1.z = -1.44269502 * r1.x;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.x = r1.z / r1.x;
  r0.z = r0.z ? r1.x : 1;
  r1.x = globalFogParams[1].w * r1.y;
  r0.z = r1.x * r0.z;
  r0.z = min(1, r0.z);
  r0.z = 1.44269502 * r0.z;
  r0.z = exp2(r0.z);
  r0.z = min(1, r0.z);
  r0.z = 1 + -r0.z;
  r1.x = -r0.z * globalFogParams[2].y + 1;
  r0.z = globalFogParams[2].y * r0.z;
  r1.z = saturate(dot(r3.xyz, globalFogParams[3].xyz));
  r1.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[4].w * r1.w;
  r1.w = exp2(r1.w);
  r1.z = log2(r1.z);
  r1.z = globalFogParams[3].w * r1.z;
  r1.z = exp2(r1.z);
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r1.www * r2.xyz + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.xyz;
  r2.xyz = r1.zzz * r3.xyz + r2.xyz;
  r2.xyz = -globalFogColorN.xyz + r2.xyz;
  r1.z = -globalFogParams[1].z * r1.y;
  r1.y = -globalFogParams[2].x + r1.y;
  r1.y = max(0, r1.y);
  r1.xy = globalFogParams[1].yx * r1.xy;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r0.z = saturate(r1.x * r1.y + r0.z);
  r1.y = 1.44269502 * r1.z;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r1.yzw = r1.yyy * r2.xyz + globalFogColorN.xyz;
  r2.x = globalFogColor.w + -r1.y;
  r2.y = globalFogColorE.w + -r1.z;
  r2.z = globalFogColorN.w + -r1.w;
  r1.xyz = r1.xxx * r2.xyz + r1.yzw;
  r1.xyz = r1.xyz + -r0.xyw;
  r0.xyz = r0.zzz * r1.xyz + r0.xyw;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 0;
  return;
}