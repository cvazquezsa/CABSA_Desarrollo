

[Forma]
Clave=CampanaDTemp
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=CMP
Nombre=Modificar Visita
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1021
PosicionInicialArriba=401
PosicionInicialAlturaCliente=65
PosicionInicialAncho=283
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaDTemp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CampanaDTemp.ListaPreciosEsp

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S



FiltroGeneral=RID = {Info.RID}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>EXEC spActualizaCampanaD :nID,:nRID<T>,Info.ID,Info.RID)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
















[Lista.ListaEnCaptura]
(Inicio)=CampanaDTemp.FechaD
CampanaDTemp.FechaD=CampanaDTemp.FechaA
CampanaDTemp.FechaA=(Fin)










[Lista.CampanaDTemp.ListaPreciosEsp]
Carpeta=Lista
Clave=CampanaDTemp.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
