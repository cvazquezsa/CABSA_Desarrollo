[Forma]
Clave=ProdAvanzar
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=68
PosicionInicialAncho=275
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=502
PosicionInicialArriba=461
Nombre=Avanzar un Lote
AccionesTamanoBoton=20x5
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.SerieLote, Nulo)
BarraHerramientas=S
AccionesCentro=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Fixedsys, 9, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.SerieLote
CarpetaVisible=S
ConFuenteEspecial=S

[(Variables).Info.SerieLote]
Carpeta=(Variables)
Clave=Info.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar]
Nombre=Cancelar
Boton=23
NombreDesplegar=<T>&Cerrar<T>
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Avanzar]
Nombre=Avanzar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Avanzar Lote
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
Expresion=ProcesarSQL(<T>spAvanzarProdSerieLote :tEmpresa, :tUsuario, :tLote<T>, Empresa, Usuario, Info.SerieLote)<BR>Asigna(Info.SerieLote, Nulo)

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Avanzar
Avanzar=(Fin)
