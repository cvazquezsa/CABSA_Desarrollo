
[Forma]
Clave=ContParalelaMovPoliza
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad Paralela - Movimientos de Contabilidad
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=461
PosicionInicialArriba=180
PosicionInicialAlturaCliente=330
PosicionInicialAncho=443
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaMovPoliza
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
ValidarCampos=S

ListaCamposAValidar=(Lista)
[Lista.ContParalelaMovPoliza.IDEmpresa]
Carpeta=Lista
Clave=ContParalelaMovPoliza.IDEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ContParalelaMovPoliza.MovOrigen]
Carpeta=Lista
Clave=ContParalelaMovPoliza.MovOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ContParalelaMovPoliza.Mov]
Carpeta=Lista
Clave=ContParalelaMovPoliza.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
IDEmpresa=93
MovOrigen=124
Mov=137
Empresa=75
BaseDatosRemota=145
EmpresaRemota=105

[Lista.ListaEnCaptura]
(Inicio)=ContParalelaMovPoliza.IDEmpresa
ContParalelaMovPoliza.IDEmpresa=ContParalelaMovPoliza.MovOrigen
ContParalelaMovPoliza.MovOrigen=ContParalelaMovPoliza.Mov
ContParalelaMovPoliza.Mov=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=(Fin)
