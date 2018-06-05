[Forma]
Clave=CteDepto
Nombre=Departamentos del Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=237
PosicionInicialArriba=279
PosicionInicialAlturaCliente=438
PosicionInicialAncho=806
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Nombre)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteDepto
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
ListaOrden=CteDepto.Departamento<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CteDepto.Cliente=<T>{Info.Cliente}<T>

[Lista.CteDepto.Departamento]
Carpeta=Lista
Clave=CteDepto.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteDepto.Nombre]
Carpeta=Lista
Clave=CteDepto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteDepto.Contacto]
Carpeta=Lista
Clave=CteDepto.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Departamento=42
Nombre=352
Contacto=305
Clave=76

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

[Lista.CteDepto.Clave]
Carpeta=Lista
Clave=CteDepto.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DatosCFD]
Nombre=DatosCFD
Boton=47
NombreEnBoton=S
NombreDesplegar=&Datos CFD
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteDeptoEnviarA
Visible=S
Antes=S


ActivoCondicion=(Empresa.CFD) o (General.CFDFlex)
AntesExpresiones=Asigna(Info.Numero, CteDepto:CteDepto.Departamento)
[Lista.ListaEnCaptura]
(Inicio)=CteDepto.Departamento
CteDepto.Departamento=CteDepto.Nombre
CteDepto.Nombre=CteDepto.Contacto
CteDepto.Contacto=CteDepto.Clave
CteDepto.Clave=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=DatosCFD
DatosCFD=(Fin)
