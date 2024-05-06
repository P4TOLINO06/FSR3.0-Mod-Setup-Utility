// ---- FNV Hash 576d3358b5846e13

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:51:47 2023

cbuffer ptfx_sprite_locals1 : register(b13)
{
  float wrapLigthtingTerm : packoffset(c0);
  float emissiveMultiplier : packoffset(c0.y);
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

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[3];
  float4 x1[3];
  float4 x2[3];
  float4 x3[3];
  float4 x4[4];
  r0.xyz = gViewInverse._m30_m31_m32 + -v0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.y = frac(globalScalars2.x);
  r0.y = round(r0.y);
  r1.xyzw = cmp(float4(2,2,1,1) == gDirectionalMult);
  r1.xyz = r1.ywy ? r1.xzz : 0;
  r0.z = cmp(0.199900001 < gCameraBias);
  r0.z = r0.z ? r1.x : 0;
  r0.w = cmp(gCameraBias < 0.800100029);
  r0.z = r0.w ? r0.z : 0;
  r2.xyzw = cmp(float4(1,0,1,0) == gAlphaCutoffMinMax.yyzz);
  r1.xw = (int2)r2.yw | (int2)r2.xz;
  r0.z = r0.z ? r1.x : 0;
  r0.z = r1.w ? r0.z : 0;
  r3.xyzw = cmp(v1.xyyz < v1.yzxy);
  r0.z = r0.z ? r3.x : 0;
  r4.xyzw = cmp(float4(0,0.200000003,0.100000001,0.5) == gCameraBias);
  r5.xyzw = r1.yyyz ? r4.xyzx : 0;
  r6.xyzw = r2.xxyx ? r5.xyzw : 0;
  r7.xyzw = r2.zzww ? r6.xyzx : 0;
  r8.xyzw = r3.xzzx ? r7.xzww : 0;
  r1.xz = cmp(float2(0.300000012,0.5) < v1.xx);
  r0.w = r1.x ? r7.y : 0;
  r4.xyz = cmp(v1.xxw < float3(0.349999994,0.800000012,0.200000003));
  r0.w = r0.w ? r4.x : 0;
  r0.zw = r3.yx ? r0.zw : 0;
  r0.w = r3.y ? r0.w : 0;
  r9.xyzw = cmp(v4.xxxx == float4(10,2,3,1));
  r1.x = r9.x ? r8.y : 0;
  r6.xy = r2.ww ? r6.wy : 0;
  r6.xy = r3.zz ? r6.xy : 0;
  r6.zw = cmp(v1.yy == v1.xz);
  r1.w = r6.z ? r7.x : 0;
  r1.w = r6.w ? r1.w : 0;
  r1.z = r1.z ? r1.w : 0;
  r1.yz = r1.yz ? r4.wy : 0;
  r1.z = r4.z ? r1.z : 0;
  r0.x = cmp(r0.x < 6);
  r0.x = r0.x ? r1.z : 0;
  r4.xyz = r3.ywy ? r8.xzw : 0;
  r1.z = r3.z ? r7.x : 0;
  r1.z = r3.w ? r1.z : 0;
  r1.y = r2.y ? r1.y : 0;
  r2.xyz = r2.yyx ? r5.yxz : 0;
  r1.w = r2.w ? r2.y : 0;
  r1.w = r3.z ? r1.w : 0;
  r1.w = r3.y ? r1.w : 0;
  r1.yzw = r9.zyy ? r1.yzw : 0;
  r3.xw = r3.ww ? r6.xy : 0;
  r2.y = cmp(14.0390596 < v4.x);
  r2.y = r2.y ? r3.w : 0;
  r3.w = cmp(v4.x < 14.0390701);
  r2.y = r2.y ? r3.w : 0;
  if (r1.x != 0) {
    r5.x = 1.60000002 * v4.w;
  } else {
    r5.x = v4.w;
  }
  r1.x = 0.449999988 * v1.w;
  r6.w = 1.30999994 * r5.x;
  r6.xyz = float3(1.72000003,1.72000003,1.72000003) * v1.xyz;
  r5.yzw = v1.xyz;
  r5.xyzw = r0.zzzz ? r6.xyzw : r5.yzwx;
  r6.x = r0.w ? r1.x : v1.w;
  r7.xyz = r5.xyz + r5.xyz;
  r5.xyz = r4.xxx ? r7.xyz : r5.xyz;
  r7.xyz = float3(1.60000002,0.819999993,0.639999986) * r5.xyz;
  r8.w = r6.x + r6.x;
  r9.y = 1.20000005 * r5.w;
  r8.xyz = float3(9.60000038,4.92000008,3.83999991) * r5.xyz;
  r0.y = cmp(0 < r0.y);
  r7.w = r0.y ? 0 : r8.w;
  r7.xyzw = r9.wwww ? r8.xyzw : r7.xyzw;
  r8.xyz = r4.yyy ? r7.xyz : r5.xyz;
  r9.x = r7.w;
  r6.y = r5.w;
  r0.yz = r4.yy ? r9.xy : r6.xy;
  r0.w = 3 * r0.z;
  r8.w = r3.x ? r0.w : r0.z;
  r5.xyz = float3(7.0999999,7.0999999,7.0999999) * r8.xyz;
  r0.z = cmp(0.000000 == gNormalMapMult);
  r0.w = 2.5 * r8.w;
  r5.w = r0.z ? r0.w : r8.w;
  r5.xyzw = r0.xxxx ? r5.xyzw : r8.xyzw;
  r6.xyzw = float4(1.5,0.850000024,0.699999988,1.39999998) * r5.xyzw;
  r4.xyzw = r4.zzzz ? r6.xyzw : r5.xyzw;
  r0.x = r4.w + r4.w;
  r4.w = r1.z ? r0.x : r4.w;
  r0.x = (int)r2.z | (int)r2.x;
  r0.x = r2.w ? r0.x : 0;
  r0.x = r3.z ? r0.x : 0;
  r0.x = r3.y ? r0.x : 0;
  r0.x = (int)r2.y | (int)r0.x;
  r2.xyzw = float4(3.9000001,2.21000004,1.82000005,1.10000002) * r4.xyzw;
  r2.xyzw = r0.xxxx ? r2.xyzw : r4.xyzw;
  r0.xzw = float3(6,6,6) * r2.xyz;
  r0.xzw = r1.yyy ? r0.xzw : r2.xyz;
  r1.xyz = float3(4,4,4) * r0.xzw;
  r0.xzw = r1.www ? r1.xyz : r0.xzw;
  r1.xyz = v7.xyz + v0.xyz;
  r2.x = v6.w;
  r2.y = v7.w;
  r2.z = v8.w;
  r1.xyz = r2.xyz + r1.xyz;
  r2.xyz = v8.xyz + -r2.xyz;
  r3.xyz = -v7.xyz + v6.xyz;
  r4.xyz = r3.xyz + r2.xyz;
  r5.xyz = float3(0.5,0.5,0.5) * r4.xyz;
  r4.xyz = r4.xyz * float3(0.5,0.5,0.5) + r1.xyz;
  r6.xy = v10.yz + -v10.xw;
  r6.zw = v11.yz + -v11.xw;
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
  r7.xy = trunc(v13.xy);
  r7.xy = (uint2)r7.xy;
  r1.w = x0[r7.x+0].x;
  r3.w = x1[r7.y+0].x;
  r1.xyz = r2.xyz * r1.www + r1.xyz;
  r1.xyz = r3.xyz * r3.www + r1.xyz;
  r2.x = dot(r5.xyz, r5.xyz);
  r2.x = sqrt(r2.x);
  r2.x = 1 / r2.x;
  o1.x = r1.w * r6.x + v10.x;
  o1.y = r3.w * r6.y + v10.w;
  o1.z = r1.w * r6.z + v11.x;
  o1.w = r3.w * r6.w + v11.w;
  r1.w = x2[r7.x+0].x;
  o2.x = r1.w * r6.x + v10.x;
  r1.w = x3[r7.y+0].x;
  o2.y = r1.w * r6.y + v10.w;
  r3.xyz = r4.xyz + -r1.xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = sqrt(r1.w);
  r1.w = r1.w * r2.x;
  o3.x = saturate(v3.x);
  r1.xyz = r1.xyz + -r4.xyz;
  r2.xyz = r2.www * r1.xyz;
  r1.xyz = r2.www * r1.xyz + r4.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r1.xyz = r3.xyz * gCameraBias + r1.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -r4.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r3.xyz = r3.xyz * gCameraBias + r4.xyz;
  r4.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r4.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r4.xyzw;
  r4.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r4.xyzw;
  r4.xyzw = gWorldViewProj._m30_m31_m32_m33 + r4.xyzw;
  r3.w = cmp(9.99999997e-07 >= r0.y);
  r0.y = r2.w * r0.y;
  o7.x = gSoftnessCurve * r1.w;
  r5.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  r1.w = dot(r5.xyz, r5.xyz);
  r2.w = sqrt(r1.w);
  r5.w = -gRG_BlendEndDistance + r2.w;
  o7.y = saturate(r5.w / gRG_BlendStartDistance);
  r6.xyz = -r3.xyz + r1.xyz;
  r5.w = dot(r6.xyz, r6.xyz);
  r6.w = cmp(r5.w < 0.00100000005);
  r5.w = rsqrt(r5.w);
  r6.xyz = r6.xyz * r5.www;
  r6.xyz = r6.www ? v2.xyz : r6.xyz;
  r6.xyz = -v2.xyz + r6.xyz;
  r6.xyz = v5.xxx * r6.xyz + v2.xyz;
  r5.w = dot(r6.xyz, r6.xyz);
  r5.w = rsqrt(r5.w);
  r6.xyw = r6.xyz * r5.www;
  r7.xyz = r0.xzw * r0.xzw;
  r8.xy = gAmbientMult * globalScalars.zy;
  r7.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r7.w = r7.w * r8.y;
  r8.y = saturate(r1.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r8.y = sqrt(r8.y);
  r8.y = -r8.y * gCSMShaderVars_shared[3].z + 1;
  r8.y = gDirectionalMult * r8.y;
  r8.z = saturate(dot(r6.xyw, -gDirectionalLight.xyz));
  r8.z = wrapLigthtingTerm + r8.z;
  r8.w = wrapLigthtingTerm + 1;
  r8.w = r8.w * r8.w;
  r8.z = saturate(r8.z / r8.w);
  r9.xyz = r8.zzz * r7.xyz;
  r9.xyz = gDirectionalColour.xyz * r9.xyz;
  o9.xyz = r9.xyz * r8.yyy;
  r8.yz = cmp(int2(0,2) >= gNumForwardLights);
  r9.x = cmp(0.000000 == gLightColourAndCapsuleExtent[0].w);
  r9.yzw = gLightPositionAndInvDistSqr[0].xyz + -r1.xyz;
  r10.xyz = -gLightPositionAndInvDistSqr[0].xyz + r1.xyz;
  r10.x = dot(r10.xyz, gLightDirectionAndFalloffExponent[0].xyz);
  r10.y = gLightColourAndCapsuleExtent[0].w + 9.99999975e-05;
  r10.x = saturate(r10.x / r10.y);
  r10.x = gLightColourAndCapsuleExtent[0].w * r10.x;
  r10.xyz = gLightDirectionAndFalloffExponent[0].xyz * r10.xxx + gLightPositionAndInvDistSqr[0].xyz;
  r10.xyz = r10.xyz + -r1.xyz;
  r9.xyz = r9.xxx ? r9.yzw : r10.xyz;
  r9.w = dot(r9.xyz, r9.xyz);
  r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
  r10.x = dot(r9.xyz, r9.xyz);
  r10.x = rsqrt(r10.x);
  r9.xyz = r10.xxx * r9.xyz;
  r9.w = saturate(-r9.w * gLightPositionAndInvDistSqr[0].w + 1);
  r10.x = -gLightDirectionAndFalloffExponent[0].w + 1;
  r10.x = r10.x * r9.w + gLightDirectionAndFalloffExponent[0].w;
  r9.w = r9.w / r10.x;
  r10.x = dot(r9.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
  r10.x = saturate(r10.x * gLightConeScale[0] + gLightConeOffset[0]);
  r9.x = saturate(dot(r9.xyz, r6.xyw));
  r9.x = wrapLigthtingTerm + r9.x;
  r9.x = saturate(r9.x / r8.w);
  r9.x = r9.x * r10.x;
  r9.x = r9.x * r9.w;
  r9.y = cmp(gLightColourAndCapsuleExtent[0].y < gLightColourAndCapsuleExtent[0].x);
  r9.zw = gLightColourAndCapsuleExtent[0].yz * float2(2.86520004,2.95910001);
  r9.z = cmp(gLightColourAndCapsuleExtent[0].x < r9.z);
  r9.y = r9.z ? r9.y : 0;
  r9.z = cmp(r9.w < gLightColourAndCapsuleExtent[0].y);
  r9.y = r9.z ? r9.y : 0;
  r9.yzw = r9.yyy ? gLightColourAndCapsuleExtent[0].yyy : gLightColourAndCapsuleExtent[0].xyz;
  r9.xyz = r9.yzw * r9.xxx;
  r9.xyz = r9.xyz * r7.xyz;
  r9.xyz = r8.yyy ? float3(0,0,0) : r9.xyz;
  r8.y = cmp(0 < gNumForwardLights);
  if (r8.y != 0) {
    r8.y = cmp(1 >= gNumForwardLights);
    r10.x = r8.y ? 1.000000 : 0;
    r10.y = cmp(0.000000 == gLightColourAndCapsuleExtent[1].w);
    r11.xyz = gLightPositionAndInvDistSqr[1].xyz + -r1.xyz;
    r12.xyz = -gLightPositionAndInvDistSqr[1].xyz + r1.xyz;
    r10.z = dot(r12.xyz, gLightDirectionAndFalloffExponent[1].xyz);
    r10.w = gLightColourAndCapsuleExtent[1].w + 9.99999975e-05;
    r10.z = saturate(r10.z / r10.w);
    r10.z = gLightColourAndCapsuleExtent[1].w * r10.z;
    r12.xyz = gLightDirectionAndFalloffExponent[1].xyz * r10.zzz + gLightPositionAndInvDistSqr[1].xyz;
    r12.xyz = r12.xyz + -r1.xyz;
    r10.yzw = r10.yyy ? r11.xyz : r12.xyz;
    r11.x = dot(r10.yzw, r10.yzw);
    r10.yzw = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.yzw;
    r11.y = dot(r10.yzw, r10.yzw);
    r11.y = rsqrt(r11.y);
    r10.yzw = r11.yyy * r10.yzw;
    r11.x = saturate(-r11.x * gLightPositionAndInvDistSqr[1].w + 1);
    r11.y = -gLightDirectionAndFalloffExponent[1].w + 1;
    r11.y = r11.y * r11.x + gLightDirectionAndFalloffExponent[1].w;
    r11.x = r11.x / r11.y;
    r11.y = dot(r10.yzw, -gLightDirectionAndFalloffExponent[1].xyz);
    r11.y = saturate(r11.y * gLightConeScale[1] + gLightConeOffset[1]);
    r10.y = saturate(dot(r10.yzw, r6.xyw));
    r10.y = wrapLigthtingTerm + r10.y;
    r10.y = saturate(r10.y / r8.w);
    r10.y = r10.y * r11.y;
    r10.y = r10.y * r11.x;
    r10.z = cmp(gLightColourAndCapsuleExtent[1].y < gLightColourAndCapsuleExtent[1].x);
    r11.xy = gLightColourAndCapsuleExtent[1].yz * float2(2.86520004,2.95910001);
    r10.w = cmp(gLightColourAndCapsuleExtent[1].x < r11.x);
    r10.z = r10.w ? r10.z : 0;
    r10.w = cmp(r11.y < gLightColourAndCapsuleExtent[1].y);
    r10.z = r10.w ? r10.z : 0;
    r11.xyz = r10.zzz ? gLightColourAndCapsuleExtent[1].yyy : gLightColourAndCapsuleExtent[1].xyz;
    r10.yzw = r11.xyz * r10.yyy;
    r10.yzw = r10.yzw * r7.xyz + r9.xyz;
    r9.xyz = r8.yyy ? r9.xyz : r10.yzw;
  } else {
    r10.x = -1;
  }
  r8.y = cmp(r10.x == 0.000000);
  r10.x = r8.z ? 1.000000 : 0;
  r11.x = cmp(0.000000 == gLightColourAndCapsuleExtent[2].w);
  r11.yzw = gLightPositionAndInvDistSqr[2].xyz + -r1.xyz;
  r12.xyz = -gLightPositionAndInvDistSqr[2].xyz + r1.xyz;
  r12.x = dot(r12.xyz, gLightDirectionAndFalloffExponent[2].xyz);
  r12.y = gLightColourAndCapsuleExtent[2].w + 9.99999975e-05;
  r12.x = saturate(r12.x / r12.y);
  r12.x = gLightColourAndCapsuleExtent[2].w * r12.x;
  r12.xyz = gLightDirectionAndFalloffExponent[2].xyz * r12.xxx + gLightPositionAndInvDistSqr[2].xyz;
  r12.xyz = r12.xyz + -r1.xyz;
  r11.xyz = r11.xxx ? r11.yzw : r12.xyz;
  r11.w = dot(r11.xyz, r11.xyz);
  r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
  r12.x = dot(r11.xyz, r11.xyz);
  r12.x = rsqrt(r12.x);
  r11.xyz = r12.xxx * r11.xyz;
  r11.w = saturate(-r11.w * gLightPositionAndInvDistSqr[2].w + 1);
  r12.x = -gLightDirectionAndFalloffExponent[2].w + 1;
  r12.x = r12.x * r11.w + gLightDirectionAndFalloffExponent[2].w;
  r11.w = r11.w / r12.x;
  r12.x = dot(r11.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
  r12.x = saturate(r12.x * gLightConeScale[2] + gLightConeOffset[2]);
  r11.x = saturate(dot(r11.xyz, r6.xyw));
  r11.x = wrapLigthtingTerm + r11.x;
  r11.x = saturate(r11.x / r8.w);
  r11.x = r11.x * r12.x;
  r11.x = r11.x * r11.w;
  r11.y = cmp(gLightColourAndCapsuleExtent[2].y < gLightColourAndCapsuleExtent[2].x);
  r11.zw = gLightColourAndCapsuleExtent[2].yz * float2(2.86520004,2.95910001);
  r11.z = cmp(gLightColourAndCapsuleExtent[2].x < r11.z);
  r11.y = r11.z ? r11.y : 0;
  r11.z = cmp(r11.w < gLightColourAndCapsuleExtent[2].y);
  r11.y = r11.z ? r11.y : 0;
  r11.yzw = r11.yyy ? gLightColourAndCapsuleExtent[2].yyy : gLightColourAndCapsuleExtent[2].xyz;
  r11.xyz = r11.yzw * r11.xxx;
  r11.xyz = r11.xyz * r7.xyz + r9.xyz;
  r10.yzw = r8.zzz ? r9.xyz : r11.xyz;
  r9.w = -1;
  r9.xyzw = r8.yyyy ? r10.yzwx : r9.xyzw;
  r8.y = cmp(r9.w == 0.000000);
  if (r8.y != 0) {
    r8.y = cmp(3 >= gNumForwardLights);
    r8.z = cmp(0.000000 == gLightColourAndCapsuleExtent[3].w);
    r10.xyz = gLightPositionAndInvDistSqr[3].xyz + -r1.xyz;
    r11.xyz = -gLightPositionAndInvDistSqr[3].xyz + r1.xyz;
    r9.w = dot(r11.xyz, gLightDirectionAndFalloffExponent[3].xyz);
    r10.w = gLightColourAndCapsuleExtent[3].w + 9.99999975e-05;
    r9.w = saturate(r9.w / r10.w);
    r9.w = gLightColourAndCapsuleExtent[3].w * r9.w;
    r11.xyz = gLightDirectionAndFalloffExponent[3].xyz * r9.www + gLightPositionAndInvDistSqr[3].xyz;
    r1.xyz = r11.xyz + -r1.xyz;
    r1.xyz = r8.zzz ? r10.xyz : r1.xyz;
    r8.z = dot(r1.xyz, r1.xyz);
    r1.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r1.xyz;
    r9.w = dot(r1.xyz, r1.xyz);
    r9.w = rsqrt(r9.w);
    r1.xyz = r9.www * r1.xyz;
    r8.z = saturate(-r8.z * gLightPositionAndInvDistSqr[3].w + 1);
    r9.w = -gLightDirectionAndFalloffExponent[3].w + 1;
    r9.w = r9.w * r8.z + gLightDirectionAndFalloffExponent[3].w;
    r8.z = r8.z / r9.w;
    r9.w = dot(r1.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
    r9.w = saturate(r9.w * gLightConeScale[3] + gLightConeOffset[3]);
    r1.x = saturate(dot(r1.xyz, r6.xyw));
    r1.x = wrapLigthtingTerm + r1.x;
    r1.x = saturate(r1.x / r8.w);
    r1.x = r1.x * r9.w;
    r1.x = r1.x * r8.z;
    r1.y = cmp(gLightColourAndCapsuleExtent[3].y < gLightColourAndCapsuleExtent[3].x);
    r8.zw = gLightColourAndCapsuleExtent[3].yz * float2(2.86520004,2.95910001);
    r1.z = cmp(gLightColourAndCapsuleExtent[3].x < r8.z);
    r1.y = r1.z ? r1.y : 0;
    r1.z = cmp(r8.w < gLightColourAndCapsuleExtent[3].y);
    r1.y = r1.z ? r1.y : 0;
    r10.xyz = r1.yyy ? gLightColourAndCapsuleExtent[3].yyy : gLightColourAndCapsuleExtent[3].xyz;
    r1.xyz = r10.xyz * r1.xxx;
    r1.xyz = r1.xyz * r7.xyz + r9.xyz;
    r9.xyz = r8.yyy ? r9.xyz : r1.xyz;
  }
  r1.x = r6.z * r5.w + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r1.y = cmp(gLightArtificialExtAmbient0.y < gLightArtificialExtAmbient0.x);
  r8.yz = gLightArtificialExtAmbient0.yz * float2(2.86520004,2.95910001);
  r1.z = cmp(gLightArtificialExtAmbient0.x < r8.y);
  r1.y = r1.z ? r1.y : 0;
  r1.z = cmp(r8.z < gLightArtificialExtAmbient0.y);
  r1.y = r1.z ? r1.y : 0;
  r8.yzw = r1.yyy ? gLightArtificialExtAmbient0.yyy : gLightArtificialExtAmbient0.xyz;
  r1.y = cmp(gLightArtificialExtAmbient1.y < gLightArtificialExtAmbient1.x);
  r10.xy = gLightArtificialExtAmbient1.yz * float2(2.86520004,2.95910001);
  r1.z = cmp(gLightArtificialExtAmbient1.x < r10.x);
  r1.y = r1.z ? r1.y : 0;
  r1.z = cmp(r10.y < gLightArtificialExtAmbient1.y);
  r1.y = r1.z ? r1.y : 0;
  r10.xyz = r1.yyy ? gLightArtificialExtAmbient1.yyy : gLightArtificialExtAmbient1.xyz;
  r8.yzw = r8.yzw * r1.xxx + r10.xyz;
  r1.y = -globalScalars2.z + 1;
  r10.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r10.xyz = globalScalars2.zzz * r10.xyz;
  r8.yzw = r8.yzw * r1.yyy + r10.xyz;
  r8.yzw = r8.yzw * r7.www;
  r1.xyz = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r10.x = gLightArtificialIntAmbient1.w;
  r10.y = gLightArtificialExtAmbient0.w;
  r10.z = gLightArtificialExtAmbient1.w;
  r5.w = saturate(dot(r10.xyz, r6.xyw));
  r1.xyz = gDirectionalAmbientColour.xyz * r5.www + r1.xyz;
  r1.xyz = r1.xyz * r8.xxx + r8.yzw;
  r1.xyz = r1.xyz * r7.xyz;
  o0.xyz = r9.xyz * gExtraLightMult + r1.xyz;
  r1.x = gCSMResolution.z * -1.5 + 1;
  r1.x = 0.5 * r1.x;
  r6.xyz = r3.xyz;
  r1.yz = float2(0,0);
  while (true) {
    r5.w = cmp((int)r1.z >= 4);
    if (r5.w != 0) break;
    r7.xyz = -gViewInverse._m30_m31_m32 + r6.xyz;
    r8.xyz = gCSMShaderVars_shared[1].xyz * r7.yyy;
    r7.xyw = r7.xxx * gCSMShaderVars_shared[0].xyz + r8.xyz;
    r7.xyz = r7.zzz * gCSMShaderVars_shared[2].xyz + r7.xyw;
    r8.xyz = r7.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
    x4[0].xyz = r8.xyz;
    r9.xyz = r7.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
    x4[1].xyz = r9.xyz;
    r10.xyz = r7.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
    x4[2].xyz = r10.xyz;
    r7.xyz = r7.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
    x4[3].xyz = r7.xyz;
    r5.w = max(abs(r10.x), abs(r10.y));
    r5.w = cmp(r5.w < r1.x);
    r5.w = r5.w ? 2 : 3;
    r6.w = max(abs(r9.x), abs(r9.y));
    r6.w = cmp(r6.w < r1.x);
    r5.w = r6.w ? 1 : r5.w;
    r6.w = max(abs(r8.x), abs(r8.y));
    r6.w = cmp(r6.w < r1.x);
    r5.w = r6.w ? 0 : r5.w;
    r6.w = (uint)r5.w;
    r7.xyz = x4[r6.w+0].xyz;
    r5.w = 0.5 + r5.w;
    r5.w = 0.25 * r5.w;
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r5.w;
    r5.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r7.z).x;
    r1.y = r5.w + r1.y;
    r6.xyz = r2.xyz * float3(0.25,0.25,0.25) + r6.xyz;
    r1.z = (int)r1.z + 1;
  }
  r1.x = r1.y * 0.25 + -1;
  o7.z = v4.z * r1.x + 1;
  r0.y = v4.y * r0.y;
  o0.w = r3.w ? 0 : r0.y;
  r0.y = -globalFogParams[0].x + r2.w;
  r0.y = max(0, r0.y);
  r1.x = r0.y / r2.w;
  r1.x = r5.z * r1.x;
  r1.y = globalFogParams[2].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r1.x = r1.x ? r1.y : 1;
  r1.y = globalFogParams[1].w * r0.y;
  r1.x = r1.y * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.y = globalFogParams[2].y * r1.x;
  r1.z = rsqrt(r1.w);
  r2.xyz = r5.xyz * r1.zzz;
  r1.z = saturate(dot(r2.xyz, globalFogParams[4].xyz));
  r1.z = log2(r1.z);
  r1.z = globalFogParams[4].w * r1.z;
  r1.z = exp2(r1.z);
  r1.w = saturate(dot(r2.xyz, globalFogParams[3].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[3].w * r1.w;
  r1.w = exp2(r1.w);
  r1.x = -r1.x * globalFogParams[2].y + 1;
  r1.x = globalFogParams[1].y * r1.x;
  r2.x = -globalFogParams[2].x + r0.y;
  r2.x = max(0, r2.x);
  r2.x = globalFogParams[1].x * r2.x;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  o4.w = saturate(r1.x * r2.x + r1.y);
  r0.y = -globalFogParams[1].z * r0.y;
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = 1 + -r0.y;
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r1.zzz * r2.xyz + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.xyz;
  r1.yzw = r1.www * r3.xyz + r2.xyz;
  r1.yzw = -globalFogColorN.xyz + r1.yzw;
  r1.yzw = r0.yyy * r1.yzw + globalFogColorN.xyz;
  r2.x = globalFogColor.w + -r1.y;
  r2.y = globalFogColorE.w + -r1.z;
  r2.z = globalFogColorN.w + -r1.w;
  o4.xyz = r1.xxx * r2.xyz + r1.yzw;
  o12.x = dot(r4.xyzw, ClipPlanes.xyzw);
  o2.zw = float2(0,0);
  o5.x = v4.x;
  o5.yzw = r0.xzw;
  o6.xy = v5.xy;
  o6.zw = float2(0,0);
  o7.w = r4.w;
  o8.xyzw = float4(0,0,0,0);
  o10.xyzw = float4(0,0,0,0);
  o11.xyzw = r4.xyzw;
  o12.yzw = float3(0,0,0);
  o3.y = v3.y;
  return;
}