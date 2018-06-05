
[Forma]
Clave=InterfaseAspel
Icono=0
CarpetaPrincipal=InterfaseAspel
Modulos=(Todos)
Nombre=Interfase Aspel

ListaCarpetas=InterfaseAspel
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=529
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=672
[InterfaseAspel]
Estilo=Hoja
Clave=InterfaseAspel
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InterfaseAspel
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[InterfaseAspel.InterfaseAspel.SistemaAspel]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.SistemaAspel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[InterfaseAspel.InterfaseAspel.Servidor]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.Servidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[InterfaseAspel.InterfaseAspel.BaseDatosNombre]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.BaseDatosNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[InterfaseAspel.Columnas]
SistemaAspel=85
Servidor=117
BaseDatosNombre=127



Empresa=89
EmpresaAspel=77
SucursalIntelisis=83

Moneda=64
TipoPeriodo=124
CtaDinero=64
Concepto=134
ConceptoDIN=143
MovNomina=124
[InterfaseAspel.InterfaseAspel.Empresa]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[InterfaseAspel.InterfaseAspel.EmpresaAspel]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.EmpresaAspel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[InterfaseAspel.InterfaseAspel.SucursalIntelisis]
Carpeta=InterfaseAspel
Clave=InterfaseAspel.SucursalIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Empresa=71
Nombre=371


Concepto=218
0=66
1=261
2=-2






[Acciones.InterfaseAspelNOI]
Nombre=InterfaseAspelNOI
Boton=0
NombreEnBoton=S
NombreDesplegar=NOI
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=InterfaseAspelNOI
Antes=S
DespuesGuardar=S
Visible=S




EspacioPrevio=S
ActivoCondicion=InterfaseAspel:InterfaseAspel.SistemaAspel = <T>NOI<T>
AntesExpresiones=Asigna(Info.Empresa,InterfaseAspel:InterfaseAspel.Empresa)


[InterfaseAspel.ListaEnCaptura]
(Inicio)=InterfaseAspel.SistemaAspel
InterfaseAspel.SistemaAspel=InterfaseAspel.Servidor
InterfaseAspel.Servidor=InterfaseAspel.BaseDatosNombre
InterfaseAspel.BaseDatosNombre=InterfaseAspel.EmpresaAspel
InterfaseAspel.EmpresaAspel=InterfaseAspel.Empresa
InterfaseAspel.Empresa=InterfaseAspel.SucursalIntelisis
InterfaseAspel.SucursalIntelisis=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=InterfaseAspelNOI
InterfaseAspelNOI=(Fin)
