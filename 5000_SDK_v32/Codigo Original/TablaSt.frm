[Forma]
Clave=TablaSt
Nombre=Tablas Conversión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=526
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=227
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaSt
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TablaSt.TablaSt
CarpetaVisible=S

[Lista.TablaSt.TablaSt]
Carpeta=Lista
Clave=TablaSt.TablaSt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TablaSt=198

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Tabla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaStD
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(TablaSt:TablaSt.TablaSt)
AntesExpresiones=Asigna(Info.Tabla,TablaSt:TablaSt.TablaSt)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tabla
Tabla=(Fin)
