[Forma]
Clave=Pais
Nombre=Paises
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=482
PosicionInicialArriba=168
PosicionInicialAltura=400
PosicionInicialAncho=402
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=354

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Pais
Fuente={MS Sans Serif, 8, Negro, []}
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
Pais=300
Estado=183
ImpuestoNomina=100
Clave=55
ClaveCURP=61

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Pais.Clave]
Carpeta=Lista
Clave=Pais.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Pais.Pais]
Carpeta=Lista
Clave=Pais.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PaisEstado]
Nombre=PaisEstado
Boton=47
NombreEnBoton=S
NombreDesplegar=&Estados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PaisEstado
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Pais:Pais.Pais)
Antes=S
AntesExpresiones=Asigna(Info.Pais, Pais:Pais.Pais)
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=Pais.Pais
Pais.Pais=Pais.Clave
Pais.Clave=(Fin)











































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=PaisEstado
PaisEstado=(Fin)
