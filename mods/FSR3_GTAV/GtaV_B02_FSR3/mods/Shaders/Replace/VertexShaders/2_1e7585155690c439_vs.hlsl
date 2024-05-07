// ---- FNV Hash 1e7585155690c439

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
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

cbuffer ped_common_shared_locals : register(b13)
{
  float4 matWetClothesData : packoffset(c0);
  float4 umPedGlobalOverrideParams : packoffset(c1);
  float4 envEffFatSweatScale : packoffset(c2);
  float paletteSelector : packoffset(c3);
  float2 StubbleGrowth : packoffset(c3.y);
  float4 _matMaterialColorScale[2] : packoffset(c4);
  float4 PedDamageColors[3] : packoffset(c6);
  float4 envEffColorModCpvAdd : packoffset(c9);
  float4 wrinkleMaskStrengths0 : packoffset(c10);
  float4 wrinkleMaskStrengths1 : packoffset(c11);
  float4 wrinkleMaskStrengths2 : packoffset(c12);
  float4 wrinkleMaskStrengths3 : packoffset(c13);
  float4 wrinkleMaskStrengths4 : packoffset(c14);
  float4 wrinkleMaskStrengths5 : packoffset(c15);
  float4 PedDamageData : packoffset(c16);
  float4 wetnessAdjust : packoffset(c17);
  float alphaToCoverageScale : packoffset(c18);
}

cbuffer pedmaterial : register(b9)
{
  float2 envEffFatThickness : packoffset(c0);
}

cbuffer pedmisclocals : register(b8)
{
  float4 umGlobalParams : packoffset(c0);
}

cbuffer pedcloth : register(b11)
{
  row_major float4x4 clothParentMatrix : packoffset(c0);
  float3 clothVertices[254] : packoffset(c4);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
  float4 v7 : COLOR0,
  float4 v8 : COLOR1,
  uint v9 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD4,
  out float4 o5 : TEXCOORD5,
  out float4 o6 : TEXCOORD6,
  out float4 o7 : TEXCOORD7,
  out float3 o8 : TEXCOORD2,
  out float4 pos : POSITION0)
{
  const float4 icb[] = { { 0.400000, 0, 1.000000, 1.000000},
                              { 0.200000, 0.400000, 1.000000, 1.000000},
                              { 0.100000, 0.600000, -1.000000, 1.000000},
                              { 0.100000, 0.700000, 1.000000, -1.000000},
                              { 0.100000, 0.800000, 1.000000, 1.000000},
                              { 0.100000, 0.900000, 1.000000, 1.000000} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v8.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(255.001953,255.001953,255.001953,255.001953) * v2.xyzw;
  r0.xyzw = (int4)r0.xyzw;
  r1.xyzw = (int4)r0.xyzw * int4(3,3,3,3);
  r2.xyzw = gBoneMtx[r0.y]._m00_m01_m02_m03 * v1.yyyy;
  r3.xyzw = gBoneMtx[r0.y]._m10_m11_m12_m13 * v1.yyyy;
  r4.xyzw = gBoneMtx[r0.y]._m20_m21_m22_m23 * v1.yyyy;
  r2.xyzw = gBoneMtx[r0.x]._m00_m01_m02_m03 * v1.xxxx + r2.xyzw;
  r3.xyzw = gBoneMtx[r0.x]._m10_m11_m12_m13 * v1.xxxx + r3.xyzw;
  r4.xyzw = gBoneMtx[r0.x]._m20_m21_m22_m23 * v1.xxxx + r4.xyzw;
  r2.xyzw = gBoneMtx[r0.z]._m00_m01_m02_m03 * v1.zzzz + r2.xyzw;
  r3.xyzw = gBoneMtx[r0.z]._m10_m11_m12_m13 * v1.zzzz + r3.xyzw;
  r4.xyzw = gBoneMtx[r0.z]._m20_m21_m22_m23 * v1.zzzz + r4.xyzw;
  r2.xyzw = gBoneMtx[r0.w]._m00_m01_m02_m03 * v1.wwww + r2.xyzw;
  r3.xyzw = gBoneMtx[r0.w]._m10_m11_m12_m13 * v1.wwww + r3.xyzw;
  r1.xyzw = gBoneMtx[r0.w]._m20_m21_m22_m23 * v1.wwww + r4.xyzw;
  r0.z = cmp(254 < (int)r0.z);
  r4.x = v7.z * v7.z;
  r4.x = cmp(r4.x != 0.000000);
  r4.x = r4.x ? 1.000000 : 0;
  r4.x = envEffColorModCpvAdd.w * r4.x + v7.z;
  r4.yzw = float3(-0.5,0.529411793,-0.0392156877) + v7.zyy;
  r4.y = saturate(r4.y);
  r4.y = r4.y + r4.y;
  if (r0.z != 0) {
    r5.x = dot(clothParentMatrix._m00_m01_m02, clothVertices[r0.w].xyz);
    r5.y = dot(clothParentMatrix._m10_m11_m12, clothVertices[r0.w].xyz);
    r5.z = dot(clothParentMatrix._m20_m21_m22, clothVertices[r0.w].xyz);
    r6.x = dot(clothParentMatrix._m00_m01_m02, clothVertices[r0.x].xyz);
    r6.y = dot(clothParentMatrix._m10_m11_m12, clothVertices[r0.x].xyz);
    r6.z = dot(clothParentMatrix._m20_m21_m22, clothVertices[r0.x].xyz);
    r7.x = dot(clothParentMatrix._m00_m01_m02, clothVertices[r0.y].xyz);
    r7.y = dot(clothParentMatrix._m10_m11_m12, clothVertices[r0.y].xyz);
    r7.z = dot(clothParentMatrix._m20_m21_m22, clothVertices[r0.y].xyz);
    r0.xyw = -r6.zxy + r5.zxy;
    r8.xyz = r7.yzx + -r6.yzx;
    r9.xyz = r8.xyz * r0.xyw;
    r0.xyw = r0.wxy * r8.yzx + -r9.xyz;
    r5.w = dot(r0.xyw, r0.xyw);
    r5.w = rsqrt(r5.w);
    r0.xyw = r5.www * r0.xyw;
    r6.xyz = v1.yyy * r6.xyz;
    r5.xyz = v1.zzz * r5.xyz + r6.xyz;
    r5.xyz = v1.xxx * r7.xyz + r5.xyz;
    r5.w = -0.5 + v1.w;
    r5.w = 0.100000001 * r5.w;
    r5.xyz = r5.www * -r0.xyw + r5.xyz;
    r6.xyz = gWorld._m10_m11_m12 * r5.yyy;
    r6.xyz = r5.xxx * gWorld._m00_m01_m02 + r6.xyz;
    r6.xyz = r5.zzz * gWorld._m20_m21_m22 + r6.xyz;
    r6.xyz = gWorld._m30_m31_m32 + r6.xyz;
    r7.xyz = gWorld._m10_m11_m12 * r0.yyy;
    r7.xyz = r0.xxx * gWorld._m00_m01_m02 + r7.xyz;
    r7.xyz = r0.www * gWorld._m20_m21_m22 + r7.xyz;
    o4.xyz = gViewInverse._m30_m31_m32 + -r6.xyz;
    r6.xyz = r0.zzz ? gBoneMtx[0]._m00_m01_m02 : r2.xyz;
    r8.xyz = r0.zzz ? gBoneMtx[0]._m10_m11_m12 : r3.xyz;
    r9.xyz = r0.zzz ? gBoneMtx[0]._m20_m21_m22 : r1.xyz;
    r5.w = dot(r6.xyz, v6.xyz);
    r6.x = dot(r8.xyz, v6.xyz);
    r6.y = dot(r9.xyz, v6.xyz);
    r6.xzw = gWorld._m10_m11_m12 * r6.xxx;
    r6.xzw = r5.www * gWorld._m00_m01_m02 + r6.xzw;
    r6.xyz = r6.yyy * gWorld._m20_m21_m22 + r6.xzw;
    r8.xyz = r6.zxy * r7.yzx;
    r8.xyz = r6.yzx * r7.zxy + -r8.xyz;
    o6.xyz = v6.www * r8.xyz;
    o5.xyz = r6.xyz;
  } else {
    r2.xyzw = r0.zzzz ? gBoneMtx[0]._m00_m01_m02_m03 : r2.xyzw;
    r3.xyzw = r0.zzzz ? gBoneMtx[0]._m10_m11_m12_m13 : r3.xyzw;
    r1.xyzw = r0.zzzz ? gBoneMtx[0]._m20_m21_m22_m23 : r1.xyzw;
    r6.xyz = v0.xyz;
    r6.w = 1;
    r5.x = dot(r2.xyzw, r6.xyzw);
    r5.y = dot(r3.xyzw, r6.xyzw);
    r5.z = dot(r1.xyzw, r6.xyzw);
    r6.xyz = gWorld._m10_m11_m12 * r5.yyy;
    r6.xyz = r5.xxx * gWorld._m00_m01_m02 + r6.xyz;
    r6.xyz = r5.zzz * gWorld._m20_m21_m22 + r6.xyz;
    r6.xyz = gWorld._m30_m31_m32 + r6.xyz;
    o4.xyz = gViewInverse._m30_m31_m32 + -r6.xyz;
    r0.x = dot(r2.xyz, v5.xyz);
    r0.y = dot(r3.xyz, v5.xyz);
    r0.w = dot(r1.xyz, v5.xyz);
    r6.xyz = gWorld._m10_m11_m12 * r0.yyy;
    r6.xyz = r0.xxx * gWorld._m00_m01_m02 + r6.xyz;
    r7.xyz = r0.www * gWorld._m20_m21_m22 + r6.xyz;
    r0.z = dot(r2.xyz, v6.xyz);
    r1.w = dot(r3.xyz, v6.xyz);
    r1.x = dot(r1.xyz, v6.xyz);
    r1.yzw = gWorld._m10_m11_m12 * r1.www;
    r1.yzw = r0.zzz * gWorld._m00_m01_m02 + r1.yzw;
    r1.xyz = r1.xxx * gWorld._m20_m21_m22 + r1.yzw;
    r2.xyz = r1.zxy * r7.yzx;
    r2.xyz = r1.yzx * r7.zxy + -r2.xyz;
    o6.xyz = v6.www * r2.xyz;
    o5.xyz = r1.xyz;
  }
  r0.xyz = envEffFatThickness.xxx * r0.xyw;
  r0.xyz = r0.xyz * r4.yyy;
  r0.xyz = r0.xyz * envEffFatSweatScale.yyy + r5.xyz;
  r1.xyz = umGlobalParams.xxy * v8.xxz;
  r1.xyz = umPedGlobalOverrideParams.xxy * r1.xyz;
  r0.w = 6.28318501 * v8.y;
  r2.xyz = umGlobalParams.zzw * umPedGlobalOverrideParams.zzw;
  r2.xyz = globalScalars2.xxx * r2.xyz + r0.www;
  r2.xyz = sin(r2.xyz);
  r0.xyz = r2.xyz * r1.xyz + r0.xyz;
  r0.w = globalScalars2.w * r4.w;
  o8.x = 0.960784316 * r0.w;
  o8.y = -v7.y * 25.5 + 1;
  r0.w = r4.z * r4.z;
  o8.z = r0.w * r4.z;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.x = cmp(v4.x != 0.000000);
  if (r0.x != 0) {
    r0.x = 0.5 + -v4.y;
    r0.x = 0.5 * r0.x;
    r0.x = (int)r0.x;
    r0.y = cmp((int)r0.x >= 2);
    r1.xyzw = v4.yxxy * float4(-1,1,1,-1) + float4(1,0,0,1);
    o7.xy = r0.yy ? r1.xy : r1.zw;
    r0.y = frac(PedDamageData.w);
    r0.zw = r0.yy * float2(-0.800000012,0.600000024) + icb[r0.x+0].xy;
    r0.y = PedDamageData.w + -r0.y;
    r0.y = 1 / r0.y;
    r1.xy = r0.yy * float2(0.600000024,-0.800000012) + icb[r0.x+0].yx;
    o7.zw = icb[r0.x+0].zw * r0.zw;
    r7.w = r1.x;
  } else {
    o7.xyzw = float4(0,0,0,0);
    r1.y = 0;
    r7.w = 0;
  }
  r0.x = cmp(matWetClothesData.w < 0);
  r0.x = r0.x ? 0 : v0.z;
  r0.xy = -matWetClothesData.xy + r0.xx;
  r0.xy = saturate(r0.xy / wetnessAdjust.ww);
  r0.z = matWetClothesData.w + -matWetClothesData.z;
  r0.x = r0.x * r0.z + matWetClothesData.z;
  r0.y = 1 + -r0.y;
  r0.x = r0.x * r0.y;
  r0.y = envEffFatSweatScale.w * v8.w;
  r1.x = max(abs(r0.x), r0.y);
  r0.x = saturate(r4.x * 2 + r4.y);
  o4.w = envEffFatSweatScale.x * r0.x;
  r1.zw = v3.xy;
  o1.xyzw = r1.zwxy;
  o2.xyzw = r7.xyzw;
  o3.xyz = v7.xyz;
  o3.w = 1;
  return;
}