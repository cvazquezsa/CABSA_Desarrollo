
[Forma]
Clave=WebArtAtributosCat
Icono=0
CarpetaPrincipal=WebArtAtributosCat
Modulos=(Todos)
Nombre=Atributos Artículos eCommerce

ListaCarpetas=WebArtAtributosCat
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=273
PosicionInicialAncho=412
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=594
PosicionInicialArriba=274
[WebArtAtributosCat]
Estilo=Hoja
Clave=WebArtAtributosCat
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtAtributosCat
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
ListaEnCaptura=WebArtAtributosCat.Tipo
CarpetaVisible=S

[WebArtAtributosCat.WebArtAtributosCat.Tipo]
Carpeta=WebArtAtributosCat
Clave=WebArtAtributosCat.Tipo
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

[Acciones.Expresion]
Nombre=Expresion
Boton=47
NombreEnBoton=S
NombreDesplegar=Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.TipoCuenta,WebArtAtributosCat:WebArtAtributosCat.Tipo)<BR>FormaModal(<T>WebArtAtributosCatD<T>)
[WebArtAtributosCat.Columnas]
Tipo=373

[WebArtAtributosCatD.Columnas]
Nombre=206
Valor=269





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
