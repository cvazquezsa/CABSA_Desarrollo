
[Forma]
Clave=CfgCuentasContablesImpuesto1
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=&Configuración Cuentas Contables por Impuesto 1
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=594
PosicionInicialArriba=249
PosicionInicialAlturaCliente=289
PosicionInicialAncho=279
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesImpuesto1
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



[Lista.Columnas]
Nombre=113
Descripcion=253
Cuenta=123

0=207
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S


EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CfgCuentasContablesImpuesto1:CfgCuentasContablesImpuesto1.Nombre)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
[Lista.ListaEnCaptura]
(Inicio)=CfgCuentasContablesImpuesto1.Nombre
CfgCuentasContablesImpuesto1.Nombre=CfgCuentasContablesImpuesto1.Cuenta
CfgCuentasContablesImpuesto1.Cuenta=(Fin)

[Lista.CfgCuentasContablesImpuesto1.Nombre]
Carpeta=Lista
Clave=CfgCuentasContablesImpuesto1.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CfgCuentasContablesImpuesto1.Cuenta]
Carpeta=Lista
Clave=CfgCuentasContablesImpuesto1.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S







[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
