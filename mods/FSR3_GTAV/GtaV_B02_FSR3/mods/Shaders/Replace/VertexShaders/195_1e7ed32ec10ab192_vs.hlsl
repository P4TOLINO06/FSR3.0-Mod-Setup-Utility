// ---- FNV Hash 1e7ed32ec10ab192

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

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
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

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

cbuffer ptfx_sprite_locals2 : register(b8)
{
  float gBlendMode : packoffset(c0);
  float4 gChannelMask : packoffset(c1);
  float gSuperAlpha : packoffset(c2);
  float gDirectionalMult : packoffset(c2.y);
  float gAmbientMult : packoffset(c2.z);
  float gShadowAmount : packoffset(c2.w);
  float gExtraLightMult : packoffset(c3);
  float gCameraBias : packoffset(c3.y);
  float gCameraShrink : packoffset(c3.z);
  float gNormalArc : packoffset(c3.w);
  float gDirNormalBias : packoffset(c4);
  float gSoftnessCurve : packoffset(c4.y);
  float gSoftnessShadowMult : packoffset(c4.z);
  float gSoftnessShadowOffset : packoffset(c4.w);
  float gNormalMapMult : packoffset(c5);
  float3 gAlphaCutoffMinMax : packoffset(c5.y);
  float gRG_BlendStartDistance : packoffset(c6);
  float gRG_BlendEndDistance : packoffset(c6.y);
}

SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float3 v2 : NORMAL0,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  float4 v10 : TEXCOORD10,
  float4 v11 : TEXCOORD11,
  uint v12 : SV_InstanceID0,
  float4 v13 : TEXCOORD3,
  float4 v14 : TEXCOORD4,
  float4 v15 : TEXCOORD5,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD5,
  out float4 o5 : TEXCOORD6,
  out float4 o6 : TEXCOORD7,
  out float4 o7 : TEXCOORD8,
  out float4 o8 : TEXCOORD9,
  out float4 o9 : TEXCOORD10,
  out float4 o10 : TEXCOORD11,
  out float4 o11 : SV_Position0,
  out float4 o12 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v8.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v9.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v10.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v11.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v13.xy
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[3];
  float4 x1[3];
  float4 x2[3];
  float4 x3[3];
  float4 x4[4];
  r0.xyz = v7.xyz + v0.xyz;
  r1.x = v6.w;
  r1.y = v7.w;
  r1.z = v8.w;
  r0.xyz = r1.xyz + r0.xyz;
  r1.xyz = v8.xyz + -r1.xyz;
  r2.xyz = -v7.xyz + v6.xyz;
  r3.xyz = r2.xyz + r1.xyz;
  r4.xyz = float3(0.5,0.5,0.5) * r3.xyz;
  r3.xyz = r3.xyz * float3(0.5,0.5,0.5) + r0.xyz;
  r5.xy = v10.yz + -v10.xw;
  r5.zw = v11.yz + -v11.xw;
  x0[0].x = v9.x;
  x0[1].x = 0.5;
  x0[2].x = v9.y;
  x1[0].x = v9.z;
  x1[1].x = 0.5;
  x1[2].x = v9.w;
  x2[0].x = v9.x;
  x2[1].x = 0.5;
  x2[2].x = v9.y;
  x3[0].x = v9.z;
  x3[1].x = 0.5;
  x3[2].x = v9.w;
  r6.xy = (int2)v13.xy;
  r0.w = x0[r6.x+0].x;
  r1.w = x1[r6.y+0].x;
  r0.xyz = r1.xyz * r0.www + r0.xyz;
  r0.xyz = r2.xyz * r1.www + r0.xyz;
  r1.x = dot(r4.xyz, r4.xyz);
  r1.x = sqrt(r1.x);
  r1.x = 1 / r1.x;
  o1.x = r0.w * r5.x + v10.x;
  o1.y = r1.w * r5.y + v10.w;
  o1.z = r0.w * r5.z + v11.x;
  o1.w = r1.w * r5.w + v11.w;
  r0.w = x2[r6.x+0].x;
  o2.x = r0.w * r5.x + v10.x;
  r0.w = x3[r6.y+0].x;
  o2.y = r0.w * r5.y + v10.w;
  r1.yzw = r3.xyz + -r0.xyz;
  r0.w = dot(r1.yzw, r1.yzw);
  r0.w = sqrt(r0.w);
  r0.w = r0.w * r1.x;
  o3.x = saturate(v3.x);
  r0.xyz = r0.xyz + -r3.xyz;
  r1.xyz = v4.www * r0.xyz;
  r0.xyz = r0.xyz * v4.www + r3.xyz;
  r2.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r0.xyz = r2.xyz * gCameraBias + r0.xyz;
  r2.xyz = gViewInverse._m30_m31_m32 + -r3.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r2.xyz = r2.xyz * gCameraBias + r3.xyz;
  r3.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r3.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r3.xyzw;
  r3.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r3.xyzw;
  r3.xyzw = gWorldViewProj._m30_m31_m32_m33 + r3.xyzw;
  r1.w = cmp(9.99999997e-07 >= v1.w);
  r2.w = v4.w * v1.w;
  o7.x = gSoftnessCurve * r0.w;
  r4.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r4.w = sqrt(r0.w);
  r5.x = -gRG_BlendEndDistance + r4.w;
  o7.y = saturate(r5.x / gRG_BlendStartDistance);
  r5.xyz = -r2.xyz + r0.xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r6.x = cmp(r5.w < 0.00100000005);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r5.xyz = r6.xxx ? v2.xyz : r5.xyz;
  r5.xyz = -v2.xyz + r5.xyz;
  r5.xyz = v5.xxx * r5.xyz + v2.xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r6.xyz = float3(1,0,0) * r5.yzx;
  r6.xyz = r5.zxy * float3(0,1,0) + -r6.xyz;
  r5.w = dot(r6.xy, r6.xy);
  r5.w = rsqrt(r5.w);
  o10.xyz = r6.xyz * r5.www;
  r5.w = -gCSMResolution.z * 1.5 + 1;
  r5.w = 0.5 * r5.w;
  r6.xyz = r2.xyz;
  r6.w = 0;
  r7.x = 0;
  while (true) {
    r7.y = (int)r7.x;
    r7.y = cmp(r7.y >= 4);
    if (r7.y != 0) break;
    r7.yzw = -gViewInverse._m30_m31_m32 + r6.xyz;
    r8.xyz = gCSMShaderVars_shared[1].xyz * r7.zzz;
    r8.xyz = r7.yyy * gCSMShaderVars_shared[0].xyz + r8.xyz;
    r7.yzw = r7.www * gCSMShaderVars_shared[2].xyz + r8.xyz;
    r8.xyz = r7.yzw * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
    x4[0].xyz = r8.xyz;
    r9.xyz = r7.yzw * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
    x4[1].xyz = r9.xyz;
    r10.xyz = r7.yzw * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
    x4[2].xyz = r10.xyz;
    r7.yzw = r7.yzw * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
    x4[3].xyz = r7.yzw;
    r7.y = max(abs(r10.x), abs(r10.y));
    r7.y = cmp(r7.y < r5.w);
    r7.y = r7.y ? 2 : 3;
    r7.z = max(abs(r9.x), abs(r9.y));
    r7.z = cmp(r7.z < r5.w);
    r7.y = r7.z ? 1 : r7.y;
    r7.z = max(abs(r8.x), abs(r8.y));
    r7.z = cmp(r7.z < r5.w);
    r7.y = r7.z ? 0 : r7.y;
    r8.xyz = x4[r7.y+0].xyz;
    r7.y = (int)r7.y;
    r7.y = 0.5 + r7.y;
    r7.y = 0.25 * r7.y;
    r9.x = 0.5 + r8.x;
    r9.y = r8.y * 0.25 + r7.y;
    r7.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r8.z).x;
    r6.w = r7.y + r6.w;
    r6.xyz = r1.xyz * float3(0.25,0.25,0.25) + r6.xyz;
    r7.x = (int)r7.x + 1;
  }
  r1.x = r6.w * 0.25 + -1;
  o7.z = v4.z * r1.x + 1;
  r1.x = v4.y * r2.w;
  o0.w = r1.w ? 0 : r1.x;
  r1.x = -globalFogParams[0].x + r4.w;
  r1.x = max(0, r1.x);
  r1.y = r1.x / r4.w;
  r1.y = r4.z * r1.y;
  r1.z = globalFogParams[2].z * r1.y;
  r1.y = cmp(0.00999999978 < abs(r1.y));
  r1.w = -1.44269502 * r1.z;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r1.z = r1.w / r1.z;
  r1.y = r1.y ? r1.z : 1;
  r1.z = globalFogParams[1].w * r1.x;
  r1.y = r1.z * r1.y;
  r1.y = min(1, r1.y);
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = min(1, r1.y);
  r1.y = 1 + -r1.y;
  r1.z = globalFogParams[2].y * r1.y;
  r0.w = rsqrt(r0.w);
  r2.xyz = r4.xyz * r0.www;
  r0.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
  r0.w = log2(r0.w);
  r0.w = globalFogParams[4].w * r0.w;
  r0.w = exp2(r0.w);
  r1.w = saturate(dot(r2.xyz, globalFogParams[3].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[3].w * r1.w;
  r1.w = exp2(r1.w);
  r1.y = -r1.y * globalFogParams[2].y + 1;
  r1.y = globalFogParams[1].y * r1.y;
  r2.x = -globalFogParams[2].x + r1.x;
  r2.x = max(0, r2.x);
  r2.x = globalFogParams[1].x * r2.x;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  o4.w = saturate(r1.y * r2.x + r1.z);
  r1.x = -globalFogParams[1].z * r1.x;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r0.www * r2.xyz + globalFogColorE.xyz;
  r4.xyz = globalFogColor.xyz + -r2.xyz;
  r2.xyz = r1.www * r4.xyz + r2.xyz;
  r2.xyz = -globalFogColorN.xyz + r2.xyz;
  r1.xzw = r1.xxx * r2.xyz + globalFogColorN.xyz;
  r2.x = globalFogColor.w + -r1.x;
  r2.y = globalFogColorE.w + -r1.z;
  r2.z = globalFogColorN.w + -r1.w;
  o4.xyz = r1.yyy * r2.xyz + r1.xzw;
  o12.x = dot(r3.xyzw, ClipPlanes.xyzw);
  o0.xyz = v1.xyz;
  o2.zw = float2(0,0);
  o5.xyzw = v4.xyzw;
  o6.xy = v5.xy;
  o6.zw = float2(0,0);
  o7.w = r3.w;
  o8.xyz = r0.xyz;
  o8.w = 0;
  o10.w = 0;
  o11.xyzw = r3.xyzw;
  o12.yzw = float3(0,0,0);
  o9.xyz = r5.xyz;
  o3.y = v3.y;
  return;
}