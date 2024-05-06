// ---- FNV Hash b6b9d3295bae00c8

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

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

cbuffer tri_uMovment_and_branch_bend_shared : register(b11)
{
  float4 branchBendEtc_WindVector[4] : packoffset(c0);
  float4 branchBendEtc_WindSpeedSoftClamp : packoffset(c4);
  float4 branchBendEtc_UnderWaterTransition : packoffset(c5);
  float4 branchBendEtc_AABBInfo[2] : packoffset(c6);
  float4 branchBendEtc_SfxWindEvalModulation : packoffset(c8);
  float4 branchBendEtc_SfxWindValueModulation : packoffset(c9);
  float4 branchBendEtc_Control1Fake : packoffset(c10);
  float4 branchBendEtc_Control2Fake : packoffset(c11);
  float4 branchBendEtc_DebugRenderControl1Fake : packoffset(c12);
  float4 branchBendEtc_DebugRenderControl2Fake : packoffset(c13);
  float4 branchBendEtc_DebugRenderControl3Fake : packoffset(c14);
}

cbuffer playercolenabled_buffer : register(b8)
{
  int bPlayerCollEnabled : packoffset(c0);
  int bVehTreeColl0Enabled : packoffset(c0.y);
  int bVehTreeColl1Enabled : packoffset(c0.z);
  int bVehTreeColl2Enabled : packoffset(c0.w);
  int bVehTreeColl3Enabled : packoffset(c1);
}

cbuffer trees_common_shared_locals : register(b9)
{
  float4 _worldPlayerPos_umGlobalPhaseShift : packoffset(c0);
  float4 _vecvehColl0[3] : packoffset(c1);
  float4 _vecvehColl1[3] : packoffset(c4);
  float4 _vecvehColl2[3] : packoffset(c7);
  float4 _vecvehColl3[3] : packoffset(c10);
  float4 umGlobalOverrideParams : packoffset(c13);
  float4 _globalEntityScale : packoffset(c14);
}

cbuffer trees_common_locals : register(b12)
{
  float4 umGlobalParams : packoffset(c0);
  float4 WindGlobalParams : packoffset(c1);
  float UseTreeNormals : packoffset(c2);
  float SelfShadowing : packoffset(c2.y);
  float AlphaScale : packoffset(c2.z);
  float AlphaTest : packoffset(c2.w);
  float ShadowFalloff : packoffset(c3);
  float AlphaScaleNormal : packoffset(c3.y);
  float AlphaClampNormal : packoffset(c3.z);
}

SamplerState SfxWindSampler3D_s : register(s2);
Texture3D<float4> SfxWindSampler3D : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float4 v3 : COLOR1,
  float2 v4 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float3 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gWorld._m10_m11_m12 * v1.yyy;
  r0.xyz = v1.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v1.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = float3(-0,-0,-1) + r0.xyz;
  r0.xyz = UseTreeNormals * r0.xyz + float3(0,0,1);
  o2.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = dot(branchBendEtc_UnderWaterTransition.xyz, v0.xyz);
  r0.x = saturate(branchBendEtc_UnderWaterTransition.w + r0.x);
  r0.y = cmp(0 < r0.x);
  if (r0.y != 0) {
    r0.y = saturate(umGlobalParams.z * branchBendEtc_WindSpeedSoftClamp.z);
    r0.y = 1 + -r0.y;
    r1.x = branchBendEtc_WindVector[1].w * globalScalars2.x;
    r1.y = branchBendEtc_WindVector[2].w * globalScalars2.x;
    r0.zw = v2.yy + r1.xy;
    r0.zw = branchBendEtc_WindVector[3].ww + r0.zw;
    r0.zw = frac(r0.zw);
    r0.zw = float2(-0.5,-0.5) + r0.zw;
    r0.zw = -abs(r0.zw) * float2(2,2) + float2(1,1);
    r1.xy = r0.zw * r0.zw;
    r0.zw = -r0.zw * float2(2,2) + float2(3,3);
    r0.zw = r1.xy * r0.zw;
    r0.zw = r0.zw * float2(2,2) + float2(-1,-1);
    r1.xy = float2(1,1) + -r0.wz;
    r1.z = r1.y * r1.x;
    r1.xy = r1.xy * r0.zw;
    r0.z = r0.z * r0.w;
    r2.xyz = branchBendEtc_WindVector[1].xyz * r1.xxx;
    r1.xzw = r1.zzz * branchBendEtc_WindVector[0].xyz + r2.xyz;
    r1.xyz = r1.yyy * branchBendEtc_WindVector[2].xyz + r1.xzw;
    r1.xyz = r0.zzz * branchBendEtc_WindVector[3].xyz + r1.xyz;
    r2.xyz = branchBendEtc_SfxWindEvalModulation.xyz * globalScalars2.xxx + v2.yyy;
    r2.xyz = branchBendEtc_WindVector[3].www + r2.xyz;
    r2.xyz = frac(r2.xyz);
    r2.xyz = float3(-0.5,-0.5,-0.5) + r2.xyz;
    r2.xyz = -abs(r2.xyz) * float3(2,2,2) + float3(1,1,1);
    r3.xyz = r2.xyz * r2.xyz;
    r2.xyz = -r2.xyz * float3(2,2,2) + float3(3,3,3);
    r2.xyz = r3.xyz * r2.xyz;
    r0.z = r2.x + r2.x;
    r0.w = cmp(0 < branchBendEtc_AABBInfo[0].w);
    if (r0.w != 0) {
      r2.xyz = r2.xyz * float3(2,2,2) + float3(-1,-1,-1);
      r2.xyz = r2.xyz * branchBendEtc_SfxWindEvalModulation.www + v0.xyz;
      r2.xyz = -branchBendEtc_AABBInfo[0].xyz + r2.xyz;
      r2.xyz = branchBendEtc_AABBInfo[1].xyz * r2.xyz;
      r2.xyzw = SfxWindSampler3D.SampleLevel(SfxWindSampler3D_s, r2.xyz, 0).xyzw;
    } else {
      r2.xyz = float3(0,0,0);
    }
    r0.w = 1 + -branchBendEtc_SfxWindValueModulation.x;
    r0.z = branchBendEtc_SfxWindValueModulation.x * r0.z;
    r0.z = r0.z * 0.5 + r0.w;
    r1.xyz = r0.zzz * r2.xyz + r1.xyz;
    r0.z = max(v2.x, v2.z);
    r1.xyz = r0.zzz * r1.xyz;
    r1.xyz = r1.xyz * r0.yyy;
    r2.x = dot(gWorld._m00_m01_m02, r1.xyz);
    r2.y = dot(gWorld._m10_m11_m12, r1.xyz);
    r2.z = dot(gWorld._m20_m21_m22, r1.xyz);
    r0.z = dot(v0.xyz, v0.xyz);
    r1.xyz = float3(0.00100000005,0,0) + abs(r2.xyz);
    r0.w = dot(r1.xyz, r1.xyz);
    r0.zw = sqrt(r0.zw);
    r1.xy = branchBendEtc_WindSpeedSoftClamp.xy * r0.yy;
    r0.y = -branchBendEtc_WindSpeedSoftClamp.x * r0.y + r0.w;
    r0.y = max(0, r0.y);
    r0.y = r0.y / r1.y;
    r0.y = -1.44269502 * r0.y;
    r0.y = exp2(r0.y);
    r0.y = 1 + -r0.y;
    r0.y = r1.y * r0.y + r1.x;
    r0.y = r0.y / r0.w;
    r0.w = cmp(r1.x >= r0.w);
    r0.w = r0.w ? 1.000000 : 0;
    r1.x = 1 + -r0.y;
    r0.y = r1.x * r0.w + r0.y;
    r1.xyz = r2.xyz * r0.yyy + v0.xyz;
    r0.y = dot(r1.xyz, r1.xyz);
    r0.y = sqrt(r0.y);
    r0.y = r0.z / r0.y;
    r0.yzw = r1.xyz * r0.yyy;
  } else {
    r0.yzw = v0.xyz;
  }
  r1.x = cmp(r0.x < 1);
  r1.yzw = umGlobalParams.xxy * v2.xxz;
  r1.yzw = umGlobalOverrideParams.xxy * r1.yzw;
  r2.x = _worldPlayerPos_umGlobalPhaseShift.w + v2.y;
  r2.x = 6.28318501 * abs(r2.x);
  r2.yzw = umGlobalParams.zzw * umGlobalOverrideParams.zzw;
  r2.xyz = globalScalars2.xxx * r2.yzw + r2.xxx;
  r2.xyz = sin(r2.xyz);
  r1.yzw = r2.xyz * r1.yzw + v0.xyz;
  r1.xyz = r1.xxx ? r1.yzw : v0.xyz;
  r1.w = 1 + -r0.x;
  r0.xyz = r0.xxx * r0.yzw;
  r0.xyz = r1.www * r1.xyz + r0.xyz;
  r1.xyz = _globalEntityScale.zzz * gWorld._m00_m01_m02;
  r2.xyz = _globalEntityScale.zzz * gWorld._m10_m11_m12;
  r3.xyz = _globalEntityScale.www * gWorld._m20_m21_m22;
  r4.xyz = _globalEntityScale.xxy * r0.xyz;
  r4.w = 1;
  r5.x = r1.x;
  r5.y = r2.x;
  r5.z = r3.x;
  r5.w = gWorld._m30;
  r6.x = dot(r4.xyzw, r5.xyzw);
  r7.x = r1.y;
  r7.y = r2.y;
  r7.z = r3.y;
  r7.w = gWorld._m31;
  r6.y = dot(r4.xyzw, r7.xyzw);
  r8.x = r1.z;
  r8.y = r2.z;
  r8.z = r3.z;
  r8.w = gWorld._m32;
  r6.z = dot(r4.xyzw, r8.xyzw);
  r4.xyz = -_worldPlayerPos_umGlobalPhaseShift.xyz + r6.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r1.w = 0.5625 + -r0.w;
  r1.w = 1.77777779 * r1.w;
  r1.w = max(0, r1.w);
  r0.w = rsqrt(r0.w);
  r4.xy = r4.xy * r0.ww;
  r4.xy = r4.xy * r1.ww;
  r6.xy = r4.xy * v2.xx + r6.xy;
  r4.xyz = -gWorld._m30_m31_m32 + r6.xyz;
  r4.xyz = _globalEntityScale.zzw * r4.xyz;
  r6.x = dot(r4.xyz, r1.xyz);
  r6.y = dot(r4.xyz, r2.xyz);
  r6.z = dot(r4.xyz, r3.xyz);
  r0.xyz = bPlayerCollEnabled ? r6.xyz : r0.xyz;
  if (bVehTreeColl0Enabled != 0) {
    r4.xyz = _globalEntityScale.xxy * r0.xyz;
    r4.w = 1;
    r5.x = dot(r4.xyzw, r5.xyzw);
    r5.y = dot(r4.xyzw, r7.xyzw);
    r0.w = dot(r4.xyzw, r8.xyzw);
    r4.xy = -_vecvehColl0[0].xy + r5.xy;
    r1.w = dot(_vecvehColl0[1].xy, r4.xy);
    r1.w = saturate(_vecvehColl0[1].w * r1.w);
    r4.xy = r1.ww * _vecvehColl0[1].xy + _vecvehColl0[0].xy;
    r4.xy = r5.xy + -r4.xy;
    r1.w = dot(r4.xy, r4.xy);
    r2.w = _vecvehColl0[2].y + -r1.w;
    r2.w = saturate(_vecvehColl0[2].z * r2.w);
    r3.w = _vecvehColl0[2].x * r2.w;
    r4.z = rsqrt(r1.w);
    r4.xy = r4.xy * r4.zz;
    r4.xy = r4.xy * r3.ww;
    r4.xy = r4.xy * v2.xx + r5.xy;
    r3.w = _vecvehColl0[2].w + -r0.w;
    r0.w = r2.w * r3.w + r0.w;
    r2.w = 0.5 * _vecvehColl0[2].x;
    r2.w = r2.w * r2.w;
    r1.w = cmp(r1.w < r2.w);
    r2.w = -0.25 + _vecvehColl0[2].w;
    r4.z = r1.w ? r2.w : r0.w;
    if (bVehTreeColl1Enabled != 0) {
      r5.xy = -_vecvehColl1[0].xy + r4.xy;
      r0.w = dot(_vecvehColl1[1].xy, r5.xy);
      r0.w = saturate(_vecvehColl1[1].w * r0.w);
      r5.xy = r0.ww * _vecvehColl1[1].xy + _vecvehColl1[0].xy;
      r5.xy = -r5.xy + r4.xy;
      r0.w = dot(r5.xy, r5.xy);
      r1.w = _vecvehColl1[2].y + -r0.w;
      r1.w = saturate(_vecvehColl1[2].z * r1.w);
      r2.w = _vecvehColl1[2].x * r1.w;
      r3.w = rsqrt(r0.w);
      r5.xy = r5.xy * r3.ww;
      r5.xy = r5.xy * r2.ww;
      r4.xy = r5.xy * v2.xx + r4.xy;
      r2.w = _vecvehColl1[2].w + -r4.z;
      r1.w = r1.w * r2.w + r4.z;
      r2.w = 0.5 * _vecvehColl1[2].x;
      r2.w = r2.w * r2.w;
      r0.w = cmp(r0.w < r2.w);
      r2.w = -0.25 + _vecvehColl1[2].w;
      r4.z = r0.w ? r2.w : r1.w;
    }
    if (bVehTreeColl2Enabled != 0) {
      r5.xy = -_vecvehColl2[0].xy + r4.xy;
      r0.w = dot(_vecvehColl2[1].xy, r5.xy);
      r0.w = saturate(_vecvehColl2[1].w * r0.w);
      r5.xy = r0.ww * _vecvehColl2[1].xy + _vecvehColl2[0].xy;
      r5.xy = -r5.xy + r4.xy;
      r0.w = dot(r5.xy, r5.xy);
      r1.w = _vecvehColl2[2].y + -r0.w;
      r1.w = saturate(_vecvehColl2[2].z * r1.w);
      r2.w = _vecvehColl2[2].x * r1.w;
      r3.w = rsqrt(r0.w);
      r5.xy = r5.xy * r3.ww;
      r5.xy = r5.xy * r2.ww;
      r4.xy = r5.xy * v2.xx + r4.xy;
      r2.w = _vecvehColl2[2].w + -r4.z;
      r1.w = r1.w * r2.w + r4.z;
      r2.w = 0.5 * _vecvehColl2[2].x;
      r2.w = r2.w * r2.w;
      r0.w = cmp(r0.w < r2.w);
      r2.w = -0.25 + _vecvehColl2[2].w;
      r4.z = r0.w ? r2.w : r1.w;
    }
    if (bVehTreeColl3Enabled != 0) {
      r5.xy = -_vecvehColl3[0].xy + r4.xy;
      r0.w = dot(_vecvehColl3[1].xy, r5.xy);
      r0.w = saturate(_vecvehColl3[1].w * r0.w);
      r5.xy = r0.ww * _vecvehColl3[1].xy + _vecvehColl3[0].xy;
      r5.xy = -r5.xy + r4.xy;
      r0.w = dot(r5.xy, r5.xy);
      r1.w = _vecvehColl3[2].y + -r0.w;
      r1.w = saturate(_vecvehColl3[2].z * r1.w);
      r2.w = _vecvehColl3[2].x * r1.w;
      r3.w = rsqrt(r0.w);
      r5.xy = r5.xy * r3.ww;
      r5.xy = r5.xy * r2.ww;
      r4.xy = r5.xy * v2.xx + r4.xy;
      r2.w = _vecvehColl3[2].w + -r4.z;
      r1.w = r1.w * r2.w + r4.z;
      r2.w = 0.5 * _vecvehColl3[2].x;
      r2.w = r2.w * r2.w;
      r0.w = cmp(r0.w < r2.w);
      r2.w = -0.25 + _vecvehColl3[2].w;
      r4.z = r0.w ? r2.w : r1.w;
    }
    r4.xyz = -gWorld._m30_m31_m32 + r4.xyz;
    r4.xyz = _globalEntityScale.zzw * r4.xyz;
    r0.x = dot(r4.xyz, r1.xyz);
    r0.y = dot(r4.xyz, r2.xyz);
    r0.z = dot(r4.xyz, r3.xyz);
  }
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v4.xy;
  o1.z = v2.w;
  o1.w = SelfShadowing;
  return;
}