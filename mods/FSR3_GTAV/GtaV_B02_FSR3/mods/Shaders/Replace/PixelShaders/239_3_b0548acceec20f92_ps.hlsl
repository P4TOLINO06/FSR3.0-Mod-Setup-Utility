// ---- FNV Hash b0548acceec20f92

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

SamplerState StaticBumpSampler_s : register(s2);
SamplerState StaticFoamSampler_s : register(s4);
SamplerState BlendSampler_s : register(s6);
SamplerState PlanarReflectionSampler_s : register(s7);
SamplerState WetSampler_s : register(s9);
SamplerState WaterBumpSampler_s : register(s10);
SamplerState RefractionSampler_s : register(s12);
SamplerState WaterBumpSampler2_s : register(s14);
SamplerState LightingSampler_s : register(s15);
Texture2D<float4> StaticBumpSampler : register(t2);
Texture2D<float4> StaticFoamSampler : register(t4);
Texture2D<float4> BlendSampler : register(t6);
Texture2D<float4> PlanarReflectionSampler : register(t7);
Texture2D<float4> WetSampler : register(t9);
Texture2D<float4> WaterBumpSampler : register(t10);
Texture2D<float4> RefractionSampler : register(t12);
Texture2D<float4> WaterBumpSampler2 : register(t14);
Texture2D<float4> LightingSampler : register(t15);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = gOceanParams0.yy * v3.xy;
  r0.zw = float2(3.70000005,3.70000005) * r0.xy;
  r1.xyzw = WaterBumpSampler2.Sample(WaterBumpSampler2_s, r0.xy).xyzw;
  r0.xyzw = WaterBumpSampler.Sample(WaterBumpSampler_s, r0.zw).xyzw;
  r1.zw = r0.xy;
  r0.xyzw = r1.xyzw * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r0.xy = r0.xy + r0.zw;
  r0.z = 0.100000001 * gScaledTime.x;
  r1.xy = v3.yx * float2(0.00223214296,0.00223214296) + r0.zz;
  r0.zw = v3.xy * float2(0.001953125,0.001953125) + -r0.zz;
  r2.xyzw = StaticBumpSampler.Sample(StaticBumpSampler_s, r0.zw).xyzw;
  r0.zw = r2.wy * float2(2,2) + float2(-1,-1);
  r1.xyzw = StaticBumpSampler.Sample(StaticBumpSampler_s, r1.xy).xyzw;
  r1.xy = r1.yw * float2(2,2) + float2(-1,-1);
  r0.zw = -r1.xy + -r0.zw;
  r0.xy = r0.zw * gOceanParams1.ww + r0.xy;
  r1.xy = r0.xy * gOceanParams0.xx + v2.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = sqrt(r0.x);
  r0.x = r0.x * 0.270000011 + 0.439999998;
  r1.z = v2.z;
  r0.y = dot(r1.xyz, r1.xyz);
  r0.y = rsqrt(r0.y);
  r2.xyz = -r1.xyz * r0.yyy + float3(0,0,1);
  r0.yzw = r1.xyz * r0.yyy;
  r1.xyz = r2.xyz * float3(0.833333313,0.833333313,0.833333313) + r0.yzw;
  r2.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r2.xyz * r1.www;
  r2.w = dot(r3.xyz, r1.xyz);
  r2.w = r2.w + r2.w;
  r1.xyz = r1.xyz * -r2.www + r3.xyz;
  r2.w = dot(-r3.xyz, r0.yzw);
  r1.z = -r2.z * r1.w + -r1.z;
  r1.z = -r2.z * r1.w + abs(r1.z);
  r3.xyz = gReflectionWorldViewProj._m10_m13_m11 * r1.yyy;
  r3.xyz = r1.xxx * gReflectionWorldViewProj._m00_m03_m01 + r3.xyz;
  r1.xyz = r1.zzz * gReflectionWorldViewProj._m20_m23_m21 + r3.xyz;
  r3.xyz = float3(0.5,0.5,0.5) * r1.xyz;
  r4.y = r1.y * 0.5 + -r3.z;
  r4.x = r3.x + r3.y;
  r1.xy = r4.xy / r1.yy;
  r3.xyzw = PlanarReflectionSampler.Sample(PlanarReflectionSampler_s, r1.xy).xyzw;
  r4.xyzw = WetSampler.Sample(WetSampler_s, v1.zw).xyzw;
  r1.x = 0.649999976 * r4.x;
  r1.y = 512 + -v3.w;
  r1.y = saturate(0.001953125 * r1.y);
  r1.x = r1.x * r1.y;
  r4.xyzw = StaticFoamSampler.Sample(StaticFoamSampler_s, v4.zw).xyzw;
  r1.y = 0.349999994 * r4.y;
  r4.x = r1.y * r0.x + r1.x;
  r4.yw = float2(0.5,0.5);
  r5.xyzw = BlendSampler.Sample(BlendSampler_s, r4.xy).xyzw;
  r1.xy = -r0.yz;
  r1.z = 0;
  r1.xyz = r2.xyz * r1.www + r1.xyz;
  r2.xyz = r2.xyz * r1.www + gDirectionalLight.xyz;
  r6.xy = v1.xy / v3.ww;
  r7.xyzw = LightingSampler.Sample(LightingSampler_s, r6.xy).xyzw;
  r1.xyz = r1.xyz * r7.yyy + v3.xyz;
  r6.z = r7.y;
  r5.xzw = gRefractionWorldViewProj._m10_m13_m11 * r1.yyy;
  r1.xyw = r1.xxx * gRefractionWorldViewProj._m00_m03_m01 + r5.xzw;
  r1.xyz = r1.zzz * gRefractionWorldViewProj._m20_m23_m21 + r1.xyw;
  r1.xyz = gRefractionWorldViewProj._m30_m33_m31 + r1.xyz;
  r1.xzw = float3(0.5,0.5,0.5) * r1.xyz;
  r4.y = r1.y * 0.5 + -r1.w;
  r4.x = r1.x + r1.z;
  r1.xy = r4.xy / r1.yy;
  r7.xyzw = LightingSampler.Sample(LightingSampler_s, r1.xy).xyzw;
  r0.x = cmp(0 != r7.z);
  r1.z = r7.y;
  r1.xyz = r0.xxx ? r6.xyz : r1.xyz;
  r0.x = r5.y * r1.z;
  r5.xyzw = RefractionSampler.Sample(RefractionSampler_s, r1.xy).xyzw;
  r1.x = dot(r0.yzw, -gDirectionalLight.xyz);
  r1.x = saturate(r1.x * 0.699999988 + 0.300000012);
  r1.xyw = gWaterDirectionalColor.xyz * r1.xxx;
  r1.xyw = r1.xyw * r7.www + gWaterAmbientColor.xyz;
  r1.xyw = r1.xyw * r0.xxx + r5.xyz;
  r3.xyz = r3.xyz + -r1.xyw;
  r0.x = 1 + -r2.w;
  r4.z = r0.x * 0.300000012 + r2.w;
  r4.xyzw = BlendSampler.Sample(BlendSampler_s, r4.zw).xyzw;
  r3.xyz = r4.xxx * r3.xyz + r1.xyw;
  r0.x = dot(r2.xyz, r2.xyz);
  r0.x = rsqrt(r0.x);
  r2.xyz = r2.xyz * r0.xxx;
  r0.x = saturate(dot(-r2.xyz, r0.yzw));
  r0.x = log2(r0.x);
  r0.x = gOceanParams0.w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = gOceanParams0.z * r0.x;
  r0.x = r0.x * r7.w;
  r0.xyz = gWaterDirectionalColor.xyz * r0.xxx + r3.xyz;
  r0.xyz = r0.xyz + -r1.xyw;
  r0.xyz = r1.zzz * r0.xyz + r1.xyw;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 0;
  return;
}