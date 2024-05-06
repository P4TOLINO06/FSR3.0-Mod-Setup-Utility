// ---- FNV Hash 1564283f9fffed39

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

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

SamplerState gDeferredLightSampler2_s : register(s4);
Texture2D<float4> gDeferredLightSampler2 : register(t4);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1 + deferredProjectionParams.w;
  r0.yz = v2.xy / v2.ww;
  r1.xyzw = gDeferredLightSampler2.Sample(gDeferredLightSampler2_s, r0.yz).xyzw;
  r2.xy = r0.yz * float2(2,-2) + float2(-1,1);
  r0.x = -r1.x + r0.x;
  r0.x = deferredProjectionParams.z / r0.x;
  r2.zw = float2(1,1);
  r1.x = dot(r2.xyz, deferredPerspectiveShearParams0.xyz);
  r1.y = dot(r2.xyz, deferredPerspectiveShearParams1.xyz);
  r1.z = dot(r2.xyz, deferredPerspectiveShearParams2.xyz);
  r0.yzw = r1.xyz * r0.xxx;
  r1.xyz = r1.xyz * r0.xxx + gViewInverse._m30_m31_m32;
  r0.x = dot(r0.yzw, r0.yzw);
  r0.yzw = -gViewInverse._m30_m31_m32 + v1.xyz;
  r2.xyz = v3.xxx * r0.yzw;
  r1.w = dot(r2.xyz, r2.xyz);
  r2.x = -r1.w + r0.x;
  r1.w = cmp(r0.x >= r1.w);
  r2.x = cmp(r2.x < 0);
  if (r2.x != 0) discard;
  r2.xyz = r0.yzw * v3.xxx + gViewInverse._m30_m31_m32;
  r2.w = dot(r2.xyzw, deferredLightParams[6].xyzw);
  r2.w = cmp(r2.w >= 0);
  r2.w = r2.w ? 1.000000 : 0;
  r3.xyz = deferredLightParams[0].xyz + -r2.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r4.x = sqrt(r3.w);
  r4.x = 1 / r4.x;
  r3.xyz = r4.xxx * r3.xyz;
  r3.x = dot(r3.xyz, -deferredLightParams[1].xyz);
  r3.x = saturate(r3.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r3.y = saturate(-r3.w * deferredLightParams[4].z + 1);
  r3.z = cmp(0 < r3.w);
  r3.w = 1 + -deferredLightParams[7].x;
  r4.x = r3.w * r3.y + deferredLightParams[7].x;
  r3.y = r3.y / r4.x;
  r3.x = r3.y * r3.x;
  r2.w = r3.x * r2.w;
  r2.w = r3.z ? r2.w : 0;
  r1.w = r1.w ? r2.w : 0;
  r4.w = 1;
  r3.xyz = r0.yzw * v3.yyy + gViewInverse._m30_m31_m32;
  r0.yzw = v3.yyy * r0.yzw;
  r0.y = dot(r0.yzw, r0.yzw);
  r0.z = cmp(r0.x >= r0.y);
  r0.y = r0.x / r0.y;
  r0.y = r0.z ? 1 : r0.y;
  r1.xyz = r0.zzz ? r3.xyz : r1.xyz;
  r1.xyz = r1.xyz + -r2.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r2.xyz;
  r0.z = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r0.z = cmp(r0.z >= 0);
  r0.z = r0.z ? 1.000000 : 0;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r2.w = sqrt(r0.w);
  r2.w = 1 / r2.w;
  r2.xyz = r2.xyz * r2.www;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r0.w * deferredLightParams[4].z + 1);
  r0.w = cmp(0 < r0.w);
  r2.z = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.z;
  r2.x = r2.y * r2.x;
  r0.z = r2.x * r0.z;
  r0.z = r0.w ? r0.z : r1.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = cmp(r0.x >= r0.w);
  r0.z = r0.w ? r0.z : 0;
  r4.w = 1;
  r0.w = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r0.w = cmp(r0.w >= 0);
  r0.w = r0.w ? 1.000000 : 0;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r2.w = dot(r2.xyz, r2.xyz);
  r3.x = sqrt(r2.w);
  r3.x = 1 / r3.x;
  r2.xyz = r3.xxx * r2.xyz;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r2.w * deferredLightParams[4].z + 1);
  r2.z = cmp(0 < r2.w);
  r2.w = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.w;
  r2.x = r2.y * r2.x;
  r0.w = r2.x * r0.w;
  r0.w = r2.z ? r0.w : r0.z;
  r0.z = r1.w + r0.z;
  r2.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = cmp(r0.x >= r1.w);
  r0.w = r1.w ? r0.w : 0;
  r4.w = 1;
  r1.w = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r1.w = cmp(r1.w >= 0);
  r1.w = r1.w ? 1.000000 : 0;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r2.w = dot(r2.xyz, r2.xyz);
  r3.x = sqrt(r2.w);
  r3.x = 1 / r3.x;
  r2.xyz = r3.xxx * r2.xyz;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r2.w * deferredLightParams[4].z + 1);
  r2.z = cmp(0 < r2.w);
  r2.w = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.w;
  r2.x = r2.y * r2.x;
  r1.w = r2.x * r1.w;
  r1.w = r2.z ? r1.w : r0.w;
  r0.z = r0.z + r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = cmp(r0.x >= r0.w);
  r0.w = r0.w ? r1.w : 0;
  r4.w = 1;
  r1.w = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r1.w = cmp(r1.w >= 0);
  r1.w = r1.w ? 1.000000 : 0;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r2.w = dot(r2.xyz, r2.xyz);
  r3.x = sqrt(r2.w);
  r3.x = 1 / r3.x;
  r2.xyz = r3.xxx * r2.xyz;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r2.w * deferredLightParams[4].z + 1);
  r2.z = cmp(0 < r2.w);
  r2.w = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.w;
  r2.x = r2.y * r2.x;
  r1.w = r2.x * r1.w;
  r1.w = r2.z ? r1.w : r0.w;
  r0.z = r0.z + r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = cmp(r0.x >= r0.w);
  r0.w = r0.w ? r1.w : 0;
  r0.z = r0.z + r0.w;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r2.w = sqrt(r1.w);
  r2.w = 1 / r2.w;
  r2.xyz = r2.xyz * r2.www;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r1.w * deferredLightParams[4].z + 1);
  r1.w = cmp(0 < r1.w);
  r2.z = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.z;
  r2.x = r2.y * r2.x;
  r4.w = 1;
  r2.y = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r1.w ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r4.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r1.xyz = r1.xyz * float3(0.125,0.125,0.125) + r4.xyz;
  r2.x = dot(r2.xyz, r2.xyz);
  r2.x = cmp(r0.x >= r2.x);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r2.xyz = deferredLightParams[0].xyz + -r4.xyz;
  r2.w = dot(r2.xyz, r2.xyz);
  r3.x = sqrt(r2.w);
  r3.x = 1 / r3.x;
  r2.xyz = r3.xxx * r2.xyz;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r2.w * deferredLightParams[4].z + 1);
  r2.z = cmp(0 < r2.w);
  r2.w = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.w;
  r2.x = r2.y * r2.x;
  r4.w = 1;
  r2.y = dot(r4.xyzw, deferredLightParams[6].xyzw);
  r3.xyz = -gViewInverse._m30_m31_m32 + r4.xyz;
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = cmp(r0.x >= r2.w);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r2.z ? r2.x : r0.w;
  r0.w = r2.w ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r2.xyz = deferredLightParams[0].xyz + -r1.xyz;
  r2.w = dot(r2.xyz, r2.xyz);
  r3.x = sqrt(r2.w);
  r3.x = 1 / r3.x;
  r2.xyz = r3.xxx * r2.xyz;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.y = saturate(-r2.w * deferredLightParams[4].z + 1);
  r2.z = cmp(0 < r2.w);
  r2.w = r3.w * r2.y + deferredLightParams[7].x;
  r2.y = r2.y / r2.w;
  r2.x = r2.y * r2.x;
  r1.w = 1;
  r1.w = dot(r1.xyzw, deferredLightParams[6].xyzw);
  r1.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  r1.x = dot(r1.xyz, r1.xyz);
  r0.x = cmp(r0.x >= r1.x);
  r1.x = cmp(r1.w >= 0);
  r1.x = r1.x ? 1.000000 : 0;
  r1.x = r2.x * r1.x;
  r0.w = r2.z ? r1.x : r0.w;
  r0.x = r0.x ? r0.w : 0;
  r0.x = r0.z + r0.x;
  r0.x = r0.x * r0.y;
  r0.x = 0.125 * r0.x;
  r0.yzw = v4.xyz * v2.zzz;
  r0.xyz = r0.yzw * r0.xxx;
  r0.w = saturate(v3.z / deferredLightVolumeParams[0].y);
  r0.xyz = r0.xyz * r0.www;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 1;
  return;
}