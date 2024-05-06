// ---- FNV Hash eef6696277904f68

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

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

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState gDeferredLightSampler0P_s : register(s2);
SamplerState PointSampler2_s : register(s6);
Texture2D<float4> gDeferredLightSampler0P : register(t2);
Texture2D<float4> PointSampler2 : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
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

  r0.xy = float2(1,0) * globalScreenSize.zw;
  r1.xyzw = gDeferredLightSampler0P.Sample(gDeferredLightSampler0P_s, v1.xy).xyzw;
  r2.xyzw = PointSampler2.Sample(PointSampler2_s, v1.xy).xyzw;
  r1.y = r1.x;
  r1.zw = float2(1,1);
  while (true) {
    r0.z = cmp(4 < r1.w);
    if (r0.z != 0) break;
    r0.zw = r1.ww * r0.xy + v1.xy;
    r3.xyzw = gDeferredLightSampler0P.Sample(gDeferredLightSampler0P_s, r0.zw).xyzw;
    r4.xyzw = PointSampler2.Sample(PointSampler2_s, r0.zw).xyzw;
    r0.z = -r4.x + r2.x;
    r0.w = -r1.w * r1.w;
    r0.z = r0.z * r0.z;
    r0.z = r0.z / r2.x;
    r0.z = 50 * r0.z;
    r0.z = r0.w * 0.0246913582 + -r0.z;
    r0.z = exp2(r0.z);
    r1.y = r3.x * r0.z + r1.y;
    r1.z = r1.z + r0.z;
    r1.w = 1 + r1.w;
  }
  r2.yz = r1.yz;
  r2.w = 5;
  while (true) {
    r0.z = cmp(8 < r2.w);
    if (r0.z != 0) break;
    r4.zw = float2(0.5,2) + r2.ww;
    r0.zw = r4.zz * r0.xy + v1.xy;
    r3.xyzw = gDeferredLightSampler0P.Sample(gDeferredLightSampler0P_s, r0.zw).xyzw;
    r5.xyzw = PointSampler2.Sample(PointSampler2_s, r0.zw).xyzw;
    r0.z = -r5.x + r2.x;
    r0.w = -r2.w * r2.w;
    r0.z = r0.z * r0.z;
    r0.z = r0.z / r2.x;
    r0.z = 50 * r0.z;
    r0.z = r0.w * 0.0246913582 + -r0.z;
    r0.z = exp2(r0.z);
    r4.x = r3.x * r0.z + r2.y;
    r4.y = r2.z + r0.z;
    r2.yzw = r4.xyw;
  }
  r1.xy = r2.yz;
  r1.z = 1;
  while (true) {
    r0.z = cmp(4 < r1.z);
    if (r0.z != 0) break;
    r0.zw = -r1.zz * r0.xy + v1.xy;
    r3.xyzw = gDeferredLightSampler0P.Sample(gDeferredLightSampler0P_s, r0.zw).xyzw;
    r4.xyzw = PointSampler2.Sample(PointSampler2_s, r0.zw).xyzw;
    r0.z = -r4.x + r2.x;
    r0.w = -r1.z * r1.z;
    r0.z = r0.z * r0.z;
    r0.z = r0.z / r2.x;
    r0.z = 50 * r0.z;
    r0.z = r0.w * 0.0246913582 + -r0.z;
    r0.z = exp2(r0.z);
    r1.x = r3.x * r0.z + r1.x;
    r1.y = r1.y + r0.z;
    r1.z = 1 + r1.z;
  }
  r2.yz = r1.xy;
  r2.w = 5;
  while (true) {
    r0.z = cmp(8 < r2.w);
    if (r0.z != 0) break;
    r3.zw = float2(0.5,2) + r2.ww;
    r0.zw = -r3.zz * r0.xy + v1.xy;
    r4.xyzw = gDeferredLightSampler0P.Sample(gDeferredLightSampler0P_s, r0.zw).xyzw;
    r5.xyzw = PointSampler2.Sample(PointSampler2_s, r0.zw).xyzw;
    r0.z = -r5.x + r2.x;
    r0.w = -r2.w * r2.w;
    r0.z = r0.z * r0.z;
    r0.z = r0.z / r2.x;
    r0.z = 50 * r0.z;
    r0.z = r0.w * 0.0246913582 + -r0.z;
    r0.z = exp2(r0.z);
    r3.x = r4.x * r0.z + r2.y;
    r3.y = r2.z + r0.z;
    r2.yzw = r3.xyw;
  }
  o0.xyzw = r2.yyyy / r2.zzzz;
  return;
}