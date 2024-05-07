// ---- FNV Hash 1ac3d5b6c2a3bded

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

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

cbuffer im_cbuffer : register(b5)
{
  float4 TexelSize : packoffset(c0);
  float4 refMipBlurParams : packoffset(c1);
  float4 GeneralParams0 : packoffset(c2);
  float4 GeneralParams1 : packoffset(c3);
  float g_fBilateralCoefficient : packoffset(c4);
  float g_fBilateralEdgeThreshold : packoffset(c4.y);
  float DistantCarAlpha : packoffset(c4.z);
  float4 tonemapColorFilterParams0 : packoffset(c5);
  float4 tonemapColorFilterParams1 : packoffset(c6);
  float4 RenderTexMSAAParam : packoffset(c7);
  float4 RenderPointMapINTParam : packoffset(c8);
}

SamplerState CoronasDepthMapSampler_s : register(s0);
Texture2D<float4> CoronasDepthMapSampler : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float3 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
  const float4 icb[] = { { 0.772968, -0.222156, 0.528241, -0.802848},
                              { 0.262963, -0.075235, 0.823705, -0.556188},
                              { 0.569683, 0.121086, 0.398884, -0.411417},
                              { 0.440016, 0.487990, -0.034640, 0.176342},
                              { -0.120323, -0.586049, 0.200466, -0.687419},
                              { -0.258614, -0.163080, -0.688321, -0.635556},
                              { -0.345086, -0.848096, -0.362813, 0.614420},
                              { 0.061750, 0.506920, 0.977316, 0.208662},
                              { 0.789433, 0.490265, -0.702313, -0.071461},
                              { -0.495341, 0.233821, 0.179311, 0.962585},
                              { -0.930975, -0.327397, -0.912985, 0.241697},
                              { -0.217266, 0.972708, -0.697119, 0.529669} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gWorldViewProj._m10_m11_m13 * v3.yyy;
  r0.xyz = v3.xxx * gWorldViewProj._m00_m01_m03 + r0.xyz;
  r0.xyz = v3.zzz * gWorldViewProj._m20_m21_m23 + r0.xyz;
  r0.xyz = gWorldViewProj._m30_m31_m33 + r0.xyz;
  r0.w = 1 / r0.z;
  r0.xy = r0.xy * r0.ww;
  r1.xy = r0.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.xyzw = CoronasDepthMapSampler.SampleLevel(CoronasDepthMapSampler_s, r1.xy, 0).xyzw;
  r1.x = cmp(r1.x >= r0.z);
  if (r1.x != 0) {
    r1.xy = gWorldViewProj._m10_m11 * v0.yy;
    r1.xy = v0.xx * gWorldViewProj._m00_m01 + r1.xy;
    r1.xy = v0.zz * gWorldViewProj._m20_m21 + r1.xy;
    r1.xy = gWorldViewProj._m30_m31 + r1.xy;
    r1.xy = r1.xy * r0.ww + -r0.xy;
    r0.w = dot(r1.xy, r1.xy);
    r0.w = sqrt(r0.w);
    r0.w = GeneralParams0.x * r0.w;
    r1.x = dot(GeneralParams0.yy, globalScreenSize.zz);
    r0.w = min(r1.x, r0.w);
    r1.xy = float2(0,0);
    while (true) {
      r1.z = cmp((int)r1.y >= 12);
      if (r1.z != 0) break;
      r2.xyzw = icb[r1.y+0].xyzw * r0.wwww + r0.xyxy;
      r2.xyzw = r2.xyzw * float4(0.5,-0.5,0.5,-0.5) + float4(0.5,0.5,0.5,0.5);
      r3.xyzw = CoronasDepthMapSampler.SampleLevel(CoronasDepthMapSampler_s, r2.xy, 0).xyzw;
      r1.z = cmp(r3.x >= r0.z);
      r1.z = r1.z ? 1.000000 : 0;
      r1.z = r1.x + r1.z;
      r2.xyzw = CoronasDepthMapSampler.SampleLevel(CoronasDepthMapSampler_s, r2.zw, 0).xyzw;
      r1.w = cmp(r2.x >= r0.z);
      r1.w = r1.w ? 1.000000 : 0;
      r1.x = r1.z + r1.w;
      r1.y = (int)r1.y + 1;
    }
  } else {
    r1.x = 0;
  }
  r0.z = 0.0416666679 * r1.x;
  r0.w = 1.00010002 + -refMipBlurParams.x;
  r0.w = 1 / r0.w;
  r0.xy = saturate(-refMipBlurParams.xx + abs(r0.xy));
  r0.x = max(r0.x, r0.y);
  r0.x = saturate(r0.x * r0.w);
  r0.x = 1 + -r0.x;
  r0.xz = r0.xz * r0.xz;
  r0.x = r0.z * r0.x;
  r0.y = cmp(0 < r0.x);
  r0.yzw = r0.yyy ? v0.xyz : v3.xyz;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.zzzz;
  r1.xyzw = r0.yyyy * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = r0.wwww * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r0.xyz = v1.xyz * r0.xxx;
  r0.xyz = v2.yyy * r0.xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + v0.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r1.x = -globalFogParams[0].x + r0.w;
  r1.x = max(0, r1.x);
  r0.w = r1.x / r0.w;
  r0.w = r1.z * r0.w;
  r1.y = globalFogParams[2].z * r0.w;
  r0.w = cmp(0.00999999978 < abs(r0.w));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r0.w = r0.w ? r1.y : 1;
  r1.y = globalFogParams[1].w * r1.x;
  r0.w = r1.y * r0.w;
  r0.w = min(1, r0.w);
  r0.w = 1.44269502 * r0.w;
  r0.w = exp2(r0.w);
  r0.w = min(1, r0.w);
  r0.w = 1 + -r0.w;
  r1.y = globalFogParams[2].y * r0.w;
  r0.w = -r0.w * globalFogParams[2].y + 1;
  r0.w = globalFogParams[1].y * r0.w;
  r1.x = -globalFogParams[2].x + r1.x;
  r1.x = max(0, r1.x);
  r1.x = globalFogParams[1].x * r1.x;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.w = saturate(r0.w * r1.x + r1.y);
  r0.w = 1 + -r0.w;
  o2.xyz = r0.xyz * r0.www;
  o1.x = v2.x;
  o1.y = v1.w;
  return;
}